class SubmissionsController < ApplicationController
  def show
    render_invalid_field_error and return if has_invalid_field
    render json: Submission.find_by!(token: params[:token]), base64_encoded: params[:base64_encoded] == "true", fields: requested_fields
  end

  def create
    wait = params[:wait] == "true"
    if wait && !Config::ENABLE_WAIT_RESULT
      render json: { error: "wait result not enabled" }, status: :bad_request
      return
    end

    submission = Submission.new(submission_params)

    if submission.save
      if wait
        render_invalid_field_error and return if has_invalid_field
        IsolateJob.perform_now(submission)
        render json: submission, status: :created, fields: requested_fields
      else
        IsolateJob.perform_later(submission)
        render json: submission, status: :created, fields: [:token]
      end
    else
      render json: submission.errors, status: :unprocessable_entity
    end
  end

  private

  def submission_params
    submission_params = params.permit(
      :source_code,
      :language_id,
      :number_of_runs,
      :input,
      :expected_output,
      :cpu_time_limit,
      :cpu_extra_time,
      :wall_time_limit,
      :memory_limit,
      :stack_limit,
      :max_processes_and_or_threads,
      :enable_per_process_and_thread_time_limit,
      :enable_per_process_and_thread_memory_limit,
      :max_file_size
    )

    params[:base64_encoded] == "true" ? decode_params(submission_params) : submission_params
  end

  def decode_params(params)
    params[:source_code] = Base64.decode64(params[:source_code]) if params[:source_code]
    params[:input] = Base64.decode64(params[:input]) if params[:input]
    params[:expected_output] = Base64.decode64(params[:expected_output]) if params[:expected_output]
    params
  end

  def has_invalid_field
    return true if @invalid_field.present?
    return false if @requested_fields.present?

    fields = params[:fields].to_s.split(",").collect(&:to_sym)
    fields.each do |field|
      unless SubmissionSerializer._attributes.include?(field)
        @invalid_field = field
        return true
      end
    end

    @requested_fields = fields.presence || self.class.default_fields

    false
  end

  def requested_fields
    has_invalid_field
    @requested_fields
  end

  def render_invalid_field_error
    render json: { error: "invalid field #{@invalid_field}" }, status: :bad_request if has_invalid_field
  end

  def self.default_fields
    @@default_fields = [
      :stdout,
      :status,
      :created_at,
      :finished_at,
      :time,
      :memory,
      :stderr,
      :token,
      :number_of_runs,
      :cpu_time_limit,
      :cpu_extra_time,
      :wall_time_limit,
      :memory_limit,
      :stack_limit,
      :max_processes_and_or_threads,
      :enable_per_process_and_thread_time_limit,
      :enable_per_process_and_thread_memory_limit,
      :max_file_size
    ]
  end
end
