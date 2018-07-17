module Builder
  class TestSuite
    def self.find_or_create(params, uuid = nil)
      if uuid
        test_suite = ::TestSuite.find_by(uuid: uuid)
        return test_suite if test_suite
      end

      test_cases = Builder::TestCase.find_or_create_many(params.presence || [{}])

      test_cases.each_with_index do |test_case, index|
        test_case.index = index
      end

      new_test_suite = ::TestSuite.new(test_cases: test_cases)

      ::TestSuite.transaction do
        old_test_suite = ::TestSuite.find_by(test_case_ids: new_test_suite.test_case_ids)
        if old_test_suite
          old_test_suite.test_cases = new_test_suite.test_cases
          return old_test_suite
        end
        new_test_suite.save(validate: false)
      end

      return new_test_suite
    end
  end
end
