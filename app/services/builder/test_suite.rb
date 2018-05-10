module Builder
  class TestSuite
    def self.find_or_create(params, uuid = nil)
      test_suite = ::TestSuite.find_by(uuid: uuid)
      return test_suite if test_suite

      test_cases = Builder::TestCase.find_or_create_many(params.presence || [{}])

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

    def self.find_or_initialize(params, uuid = nil)
      test_suite = ::TestSuite.find_by(uuid: uuid)
      return test_suite if test_suite

      test_cases = Builder::TestCase.find_or_initialize_many(params.presence || [{}])

      test_cases.each_with_index do |test_case, index|
        test_case.index = index
      end

      test_suite = ::TestSuite.new
      test_suite.test_cases = test_cases

      existing_test_suite = ::TestSuite.find_by(test_case_ids: test_suite.test_case_ids)
      if existing_test_suite
        existing_test_suite.test_cases = test_cases
        return existing_test_suite
      end

      return test_suite
    end
  end
end
