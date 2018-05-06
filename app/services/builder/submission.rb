module Builder
  class Submission
    def self.new_submission(params)
      params = params.try(:deep_symbolize_keys) || params.deep_dup

      submission = ::Submission.new(
        params.except(
          :source_code,
          :stdin,
          :expected_output
        )
      )

      submission.source          = ::Document.find_or_initialize_with_content(params[:source_code])
      submission.stdin           = ::Document.find_or_initialize_with_content(params[:stdin])
      submission.expected_output = ::Document.find_or_initialize_with_content(params[:expected_output])

      submission
    end
  end
end