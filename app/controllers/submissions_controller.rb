class SubmissionsController < ApplicationController
  before_action :authorize_request, only: [:index]

  def index
    submission_fields = Fields::Submission.new(params[:fields])
    if submission_fields.has_invalid_fields?
      render_invalid_fields_error(submission_fields.invalid_fields)
      return
    end

    pagination_service = PaginationService.new(params)
    if pagination_service.has_invalid_page?
      render_invalid_page_error(pagination_service.page)
      return
    elsif pagination_service.has_invalid_per_page?
      render_invalid_per_page_error(pagination_service.per_page)
      return
    end

    render json: pagination_service.paginate(
                   Submission, 
                   SubmissionSerializer,
                   {
                     base64_encoded: params[:base64_encoded] == "true", 
                     fields:         submission_fields.fields
                   }
                 )
  end

  def show
    submission_fields = Fields::Submission.new(params[:fields])
    if submission_fields.has_invalid_fields?
      render_invalid_fields_error(submission_fields.invalid_fields)
    else
      render json:           Submission.find_by!(token: params[:token]),
             serializer:     SubmissionSerializer,
             base64_encoded: params[:base64_encoded] == "true",
             fields:         submission_fields.fields
    end
  end

  def create
    wait = params[:wait] == "true"
    if wait && !Rails.configuration.api[:enable_wait_result]
      render json: { error: "wait not allowed" }, status: :bad_request
      return
    end

    submission_params_decoder = ParamsDecoder::Submission.new(submission_params, params[:base64_encoded] == "true")
    submission = Builder::Submission.new_submission(submission_params_decoder.params)

    if submission.save
      if wait
        submission_fields = Fields::Submission.new(params[:fields])
        if submission_fields.has_invalid_fields?
          render_invalid_fields_error(submission_fields.invalid_fields)
          return
        end
        IsolateJob.perform_now(submission)
        render json:           submission,
               status:         :created, 
               serializer:     SubmissionSerializer,
               base64_encoded: params[:base64_encoded] == "true", 
               fields:         submission_fields.fields
      else
        IsolateJob.perform_later(submission)
        render json:       submission, 
               status:     :created, 
               serializer: SubmissionSerializer,
               fields:     [:token]
      end
    else
      render json: submission.errors, status: :unprocessable_entity
    end
  end

  private

  def submission_params
    params.permit(
      :source_code,
      :language_id,
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
      :max_file_size
    )
  end
end
