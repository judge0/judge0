module Fields
  class TestCase < Base
    def initialize(fields_str)
      super(fields_str)
    end

    def default_fields
      [:uuid, :input, :output]
    end

    def serializer
      TestCaseSerializer
    end
  end
end