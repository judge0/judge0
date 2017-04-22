class ChangeEncodeAllSubmissions < ActiveRecord::Migration[5.0]
  def change
    Submission.all.each do |submission|
      submission.source_code = submission[:source_code]
      submission.input = submission[:input]
      submission.stdout = submission[:stdout]
      submission.expected_output = submission[:expected_output]
      submission.stderr = submission[:stderr]
      submission.save
    end
  end
end
