module SubmissionService

  def self.new_submission_from_params(params)
    submission = Submission.new(params.except(:source_code, :stdin, :expected_output))

    submission.source = Document.find_or_create_with_content(params[:source_code])
    submission.stdin = Document.find_or_create_with_content(params[:stdin])
    submission.expected_output = Document.find_or_create_with_content(params[:expected_output])

    submission
  end
end