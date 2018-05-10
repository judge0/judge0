module Builder
  class Submission
    def self.new_submission(params)
      submission = ::Submission.new(
        params.except(
          :source,
          :test_cases,
          :test_suite_uuid
        )
      )

      test_suite = Builder::TestSuite.find_or_initialize(params[:test_cases], params[:test_suite_uuid])

      test_suite.test_cases.each_with_index do |test_case, index|
        submission.submission_results.new(test_case: test_case, index: index)
      end

      submission.source = ::Document.find_or_initialize_with_content(params[:source])

      submission
    end
  end
end
