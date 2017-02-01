class SubmissionsController < ApplicationController
  def show
    render json: Submission.find_by(token: params[:token])
  end

  def create
    @submission = Submission.new(submission_params)
    @submission.status = Status.in_queue

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
      :input,
      :expected_output
    )
  end
end
