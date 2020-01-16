module Fields
  class Submission
    UNIVERSAL_FIELD = :*

    attr_reader :requested_fields, :invalid_fields

    def initialize(fields)
      @invalid_fields = []

      fields = fields.to_s.split(",").collect(&:to_sym)

      fields.each do |field|
        if field != UNIVERSAL_FIELD && !available_fields.include?(field)
          @invalid_fields << field
        end
      end

      if fields.include?(UNIVERSAL_FIELD)
        @requested_fields = available_fields
      else
        @requested_fields = (fields - @invalid_fields).presence || default_fields
      end
    end

    def has_invalid_fields?
      !@invalid_fields.empty?
    end

    def available_fields
      serializer._attributes
    end

    def default_fields
      serializer.default_fields
    end

    def serializer
      SubmissionSerializer
    end
  end
end