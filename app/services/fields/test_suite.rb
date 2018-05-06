module Fields
  class TestSuite < Base
    def initialize(fields_str, override_default_fields = nil)
      super(fields_str, override_default_fields)
    end

    def default_fields
      [:uuid, :test_cases]
    end

    def serializer
      TestSuiteSerializer
    end
  end
end