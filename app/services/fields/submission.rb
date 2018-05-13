module Fields
  class Submission < Base
    def initialize(fields_str, override_default_fields = nil)
      super(fields_str, override_default_fields)
    end

    def default_fields
      [
        :uuid,
        :status,
        :compile_output,
        :internal_message,
        :language,
        :finished_at,
        :results
      ]
    end

    def serializer
      SubmissionSerializer
    end
  end
end