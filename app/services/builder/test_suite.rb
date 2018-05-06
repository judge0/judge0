module Builder
  class TestSuite
    def self.find_or_create(params, uuid = nil)
      test_suite = ::TestSuite.find_by(uuid: uuid)
      return test_suite if test_suite

      test_cases = Builder::TestCase.find_or_create_many(params)
      if test_cases.empty?
        test_cases << Builder::TestCase.find_or_create({input: nil, output: nil})
      end

      test_cases.each_with_index do |test_case, index|
        test_case.index = index
      end

      test_suite = ::TestSuite.new
      test_suite.test_cases = test_cases
      
      if test_suite.save
        return test_suite
      end

      test_suite = ::TestSuite.find_by(test_case_ids: test_suite.test_case_ids)
      test_suite.test_cases = test_cases
      test_suite
    end
  end
end