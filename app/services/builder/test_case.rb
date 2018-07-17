module Builder
  class TestCase
    def self.find_or_create(params)
      if params[:test_case_uuid]
        test_case = ::TestCase.find_by(uuid: params[:test_case_uuid])
        return test_case if test_case
      end

      input = ::Document.find_or_create_with_content(params[:input])
      output = ::Document.find_or_create_with_content(params[:output])

      new_test_case = ::TestCase.new(input: input, output: output)
      ::TestCase.transaction do
        old_test_case = ::TestCase.find_by(input: input, output: output)
        return old_test_case if old_test_case
        new_test_case.save(validate: false)
      end
      return new_test_case
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
