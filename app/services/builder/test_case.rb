module Builder
  class TestCase
    def self.find_or_create(params)
      return ::TestCase.find_by(uuid: params[:test_case_uuid]) if params[:test_case_uuid]
      ::TestCase.find_or_create_by(
        input:  Document.find_or_create_with_content(params[:input]),
        output: Document.find_or_create_with_content(params[:output])
      )
    end

    def self.find_or_create_many(params) # [ActionController::Parameters ...]
      test_cases = []
      params.each do |param|
        test_cases << find_or_create(param)
      end
      test_cases
    end
  end
end