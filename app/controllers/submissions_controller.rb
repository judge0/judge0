class SubmissionsController < ApplicationController
  def show
    render json: Submission.find_by!(token: params[:token])
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      IsolateJob.perform_later(@submission)
      render json: @submission, status: :created, fields: [:token]
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  private

  def submission_params
    params.permit(
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
  end
end
