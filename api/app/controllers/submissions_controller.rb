class SubmissionsController < ApplicationController
  def show
    set_submission
    render json: @submission
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      IsolateJob.perform_later(@submission)
      render json: @submission, status: :created, serializer: SubmissionCreateSerializer
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  private
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(
      :source_code,
      :language_id,
      :input,
      :expected_output,
      :actual_output
    )
  end
end
