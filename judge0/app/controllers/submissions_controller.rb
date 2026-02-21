class SubmissionsController < ApplicationController
  before_action :authorize_request, only: [:index, :destroy]
  before_action :check_maintenance, only: [:create, :destroy]
  before_action :check_wait, only: [:create] # Wait in batch_create is not allowed
  before_action :check_batched_submissions, only: [:batch_create, :batch_show]
  before_action :check_queue_size, only: [:create, :batch_create]
  before_action :check_requested_fields, except: [:batch_create] # Fields are ignored in batch_create
  before_action :set_base64_encoded

  def index
    page = params[:page].try(:to_i) || 1
    per_page = params[:per_page].try(:to_i) || Submission.per_page

    if page <= 0
      render json: { error: "invalid page: #{page}" }, status: :bad_request
      return
    elsif per_page < 0
      render json: { error: "invalid per_page: #{per_page}" }, status: :bad_request
      return
    end

    submissions = Submission.paginate(page: page, per_page: per_page)
    serializable_submissions = ActiveModelSerializers::SerializableResource.new(
      submissions, { each_serializer: SubmissionSerializer, base64_encoded: @base64_encoded, fields: @requested_fields }
    )

    render json: {
      submissions: serializable_submissions.as_json,
      meta: pagination_dict(submissions)
    }
  rescue Encoding::UndefinedConversionError => e
    render json: {
      error: "some attributes for one or more submissions cannot be converted to UTF-8, use base64_encoded=true query parameter"
    }, status: :bad_request
  end

  def destroy
    if !Config::ENABLE_SUBMISSION_DELETE
      render json: { error: "delete not allowed" }, status: :bad_request
      return
    end

    submission = Submission.find_by!(token: params[:token])
    if submission.status == Status.queue || submission.status == Status.process
      render json: {
        error: "submission cannot be deleted because its status is #{submission.status.id} (#{submission.status.name})"
      }, status: :bad_request
      return
    end

    submission.delete

    # Forcing base64_encoded=true because it guarantees user will get requested data after delete.
    render json: submission, base64_encoded: true, fields: @requested_fields
  end

  def show
    token = params[:token]
    render json: Rails.cache.fetch("#{token}", expires_in: Config::SUBMISSION_CACHE_DURATION, race_condition_ttl: 0.1*Config::SUBMISSION_CACHE_DURATION) {
      Submission.find_by!(token: token)
    }, base64_encoded: @base64_encoded, fields: @requested_fields
  rescue Encoding::UndefinedConversionError
    render_conversion_error(:bad_request)
  end

  def batch_show
    tokens = (request.headers[:tokens] || params[:tokens]).to_s.strip.split(",")

    if tokens.length > Config::MAX_SUBMISSION_BATCH_SIZE
      render json: {
        error: "number of submissions in a batch should be less than or equal to #{Config::MAX_SUBMISSION_BATCH_SIZE}"
      }, status: :bad_request
      return
    elsif tokens.length == 0
      render json: {
        error: "there should be at least one submission in a batch"
      }, status: :bad_request
      return
    end

    existing_submissions = Hash[Submission.where(token: tokens).collect{ |s| [s.token, s] }]

    submissions = []
    tokens.each do |token|
      if existing_submissions.has_key?(token)
        serialized_submission  = ActiveModelSerializers::SerializableResource.new(
          existing_submissions[token], { serializer: SubmissionSerializer, base64_encoded: @base64_encoded, fields: @requested_fields }
        )
        submissions << serialized_submission.as_json
      else
        submissions << nil
      end
    end

    render json: { submissions: submissions }
  rescue Encoding::UndefinedConversionError => e
    render json: {
      error: "some attributes for one or more submissions cannot be converted to UTF-8, use base64_encoded=true query parameter"
    }, status: :bad_request
  end

  def create
    submission = Submission.new(submission_params(params))

    if submission.save
      if @wait
        begin
          IsolateRunner.perform_now(submission)
          submission.reload
          render json: submission, status: :created, base64_encoded: @base64_encoded, fields: @requested_fields
        rescue Encoding::UndefinedConversionError => e
          render_conversion_error(:created, submission.token)
        end
      else
        IsolateRunner.perform_later(submission)
        render json: submission, status: :created, fields: [:token]
      end
    else
      render json: submission.errors, status: :unprocessable_entity
    end
  end

  # Batch Create does not support sync (wait=true) mode.
  def batch_create
    number_of_submissions = params[:submissions].try(:size).to_i

    if number_of_submissions > Config::MAX_SUBMISSION_BATCH_SIZE
      render json: {
        error: "number of submissions in a batch should be less than or equal to #{Config::MAX_SUBMISSION_BATCH_SIZE}"
      }, status: :bad_request
      return
    elsif number_of_submissions == 0
      render json: {
        error: "there should be at least one submission in a batch"
      }, status: :bad_request
      return
    end

    submissions = params[:submissions].each.collect{ |p| Submission.new(submission_params(p)) }

    response = []
    has_valid_submission = false

    submissions.each do |submission|
      if submission.save
        IsolateRunner.perform_later(submission)
        response << { token: submission.token }
        has_valid_submission = true
      else
        response << submission.errors
      end
    end

    render json: response, status: has_valid_submission ? :created : :unprocessable_entity
  end

  private

  def submission_params(params)
    submission_params = params.permit(
      :source_code,
      :language_id,
      :compiler_options,
      :command_line_arguments,
      :number_of_runs,
      :stdin,
      :expected_output,
      :cpu_time_limit,
      :cpu_extra_time,
      :wall_time_limit,
      :memory_limit,
      :stack_limit,
      :max_processes_and_or_threads,
      :enable_per_process_and_thread_time_limit,
      :enable_per_process_and_thread_memory_limit,
      :max_file_size,
      :redirect_stderr_to_stdout,
      :callback_url,
      :additional_files,
      :enable_network
    )

    submission_params[:additional_files] = Base64Service.decode(submission_params[:additional_files])

    if @base64_encoded
      submission_params[:source_code] = Base64Service.decode(submission_params[:source_code])
      submission_params[:stdin] = Base64Service.decode(submission_params[:stdin])
      submission_params[:expected_output] = Base64Service.decode(submission_params[:expected_output])
    end

    submission_params
  end

  def check_wait
    @wait = params[:wait] == "true"
    if @wait && !Config::ENABLE_WAIT_RESULT
      render json: { error: "wait not allowed" }, status: :bad_request
    end
  end

  def check_batched_submissions
    unless Config::ENABLE_BATCHED_SUBMISSIONS
      render json: { error: "batched submissions are not allowed" }, status: :bad_request
    end
  end

  def check_queue_size
    number_of_submissions = params[:submissions].try(:size).presence || 1
    if Resque.size(ENV["JUDGE0_VERSION"]) + number_of_submissions > Config::MAX_QUEUE_SIZE
      render json: { error: "queue is full" }, status: :service_unavailable
    end
  end

  def check_requested_fields
    fields_service = Fields::Submission.new(params[:fields])
    render json: { error: "invalid fields: [#{fields_service.invalid_fields.join(", ")}]" }, status: :bad_request if fields_service.has_invalid_fields?
    @requested_fields = fields_service.requested_fields
  end

  def set_base64_encoded
    if Config::DISABLE_IMPLICIT_BASE64_ENCODING
      @base64_encoded = params[:base64_encoded] == "true"
    else
      @base64_encoded = params[:base64_encoded] != "false"
    end
  end

  def render_conversion_error(status, token = nil)
    response_json = {
      error: "some attributes for this submission cannot be converted to UTF-8, use base64_encoded=true query parameter",
    }
    response_json[:token] = token if token

    render json: response_json, status: status
  end
end
