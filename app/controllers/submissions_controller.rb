class SubmissionsController < ApplicationController
  before_action :authorize_request, only: [:index]

  def index
    if params[:fields] == "*"
      params[:submission_fields] ||= "*"
      params[:result_fields]     ||= "*"
      params[:test_case_fields]  ||= "*"
    end

    submission_fields = Fields::Submission.new(params[:submission_fields])
    if submission_fields.has_invalid_fields?
      render_invalid_fields_error(submission_fields.invalid_fields, "submission")
      return
    end

    result_fields = Fields::SubmissionResult.new(params[:result_fields])
    if result_fields.has_invalid_fields?
      render_invalid_fields_error(result_fields.invalid_fields, "result")
      return
    end

    test_case_fields = Fields::TestCase.new(params[:test_case_fields], [:uuid])
    if test_case_fields.has_invalid_fields?
      render_invalid_fields_error(test_case_fields.invalid_fields, "test case")
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
                     base64_encoded:   params[:base64_encoded] == "true",
                     fields:           submission_fields.fields,
                     result_fields:    result_fields.fields,
                     test_case_fields: test_case_fields.fields
                   }
                 )
  end

  def show
    if params[:fields] == "*"
      params[:submission_fields] ||= "*"
      params[:result_fields]     ||= "*"
      params[:test_case_fields]  ||= "*"
    end

    submission_fields = Fields::Submission.new(params[:submission_fields])
    if submission_fields.has_invalid_fields?
      render_invalid_fields_error(submission_fields.invalid_fields, "submission")
      return
    end

    result_fields = Fields::SubmissionResult.new(params[:result_fields])
    if result_fields.has_invalid_fields?
      render_invalid_fields_error(result_fields.invalid_fields, "result")
      return
    end

    test_case_fields = Fields::TestCase.new(params[:test_case_fields], [:uuid])
    if test_case_fields.has_invalid_fields?
      render_invalid_fields_error(test_case_fields.invalid_fields, "test case")
      return
    end

    render json:             Submission.find_by!(token: params[:token]),
           serializer:       SubmissionSerializer,
           base64_encoded:   params[:base64_encoded] == "true",
           fields:           submission_fields.fields,
           result_fields:    result_fields.fields,
           test_case_fields: test_case_fields.fields
  end

  def create
    wait = params[:wait] == "true"
    if wait && !Rails.configuration.api[:enable_wait_result]
      render json: { error: "wait not allowed" }, status: :bad_request
      return
    end

    if params[:fields] == "*"
      params[:submission_fields] ||= "*"
      params[:result_fields]     ||= "*"
      params[:test_case_fields]  ||= "*"
    end

    submission_fields = Fields::Submission.new(params[:submission_fields])
    if wait && submission_fields.has_invalid_fields?
      render_invalid_fields_error(submission_fields.invalid_fields, "submission")
      return
    end

    result_fields = Fields::SubmissionResult.new(params[:result_fields])
    if wait && result_fields.has_invalid_fields?
      render_invalid_fields_error(result_fields.invalid_fields, "result")
      return
    end

    test_case_fields = Fields::TestCase.new(params[:test_case_fields], [:uuid])
    if wait && test_case_fields.has_invalid_fields?
      render_invalid_fields_error(test_case_fields.invalid_fields, "test case")
      return
    end

    submission_params_decoder = ParamsDecoder::Submission.new(submission_params, params[:base64_encoded] == "true")
    submission = Builder::Submission.new_submission(submission_params_decoder.params)

    if submission.save
      if wait
        IsolateJob.perform_now(submission)
        render json:             submission,
               status:           :created,
               serializer:       SubmissionSerializer,
               base64_encoded:   params[:base64_encoded] == "true",
               fields:           submission_fields.fields,
               result_fields:    result_fields.fields,
               test_case_fields: test_case_fields.fields
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
      :language_id,
      :cpu_time_limit,
      :cpu_extra_time,
      :wall_time_limit,
      :memory_limit,
      :stack_limit,
      :max_processes_and_or_threads,
      :enable_per_process_and_thread_time_limit,
      :enable_per_process_and_thread_memory_limit,
      :max_file_size,
      :number_of_runs,
      :source,
      :test_suite_uuid,
      test_cases: [:input, :output, :test_case_uuid],
    )
  end
end
