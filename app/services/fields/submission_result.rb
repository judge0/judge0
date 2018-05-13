module Fields
  class SubmissionResult < Base
    def initialize(fields_str, override_default_fields = nil)
      super(fields_str, override_default_fields)
    end

    def default_fields
      [
        :test_case_uuid,
        :status,
        :time,
        :memory,
        :stdout,
        :stderr,
        :compile_output,
        :finished_at
      ]
    end

    def serializer
      SubmissionResultSerializer
    end
  end
end