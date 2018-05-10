module Builder
  class TestCase
    def self.find_or_create(params)
      test_case = ::TestCase.find_by(uuid: params[:test_case_uuid])
      return test_case if test_case

      ::TestCase.find_or_create_by(
        input:  ::Document.find_or_create_with_content(params[:input]),
        output: ::Document.find_or_create_with_content(params[:output])
      )
    end

    def self.find_or_initialize(params)
      test_case = ::TestCase.find_by(uuid: params[:test_case_uuid])
      return test_case if test_case

      ::TestCase.find_or_initialize_by(
        input:  ::Document.find_or_initialize_with_content(params[:input]),
        output: ::Document.find_or_initialize_with_content(params[:output])
      )
    end

    def self.find_or_create_many(params) # [ActionController::Parameters ...]
      test_cases = []
      params.each do |param|
        test_cases << find_or_create(param)
      end
      test_cases
    end

    def self.find_or_initialize_many(params) # [ActionController::Parameters ...]
      test_cases = []
      params.each do |param|
        test_cases << find_or_initialize(param)
      end
      test_cases
    end
  end
end
