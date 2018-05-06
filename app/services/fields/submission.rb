module Fields
  class Submission < Base
    def initialize(fields_str, override_default_fields = nil)
      super(fields_str, override_default_fields)
    end

    def default_fields
      [
        :token,
        :time,
        :memory,
        :stdout,
        :stderr,
        :compile_output,
        :message,
        :status
      ]
    end

    def serializer
      SubmissionSerializer
    end
  end
end