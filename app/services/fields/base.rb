module Fields
  class Base

    attr_reader :fields, :invalid_fields

    def initialize(fields_str, override_default_fields = nil)
      fields = fields_str.to_s.split(",").collect(&:to_sym)

      @fields         = []
      @invalid_fields = []

      if fields.include?(:*)
        @fields = serializer._attributes
        return
      end

      fields.each do |field|
        if serializer._attributes.include?(field)
          @fields << field
        else
          @invalid_fields << field
        end
      end

      @fields = @fields.presence || override_default_fields || default_fields
      return
    end

    def has_invalid_fields?
      !@invalid_fields.empty?
    end

    def default_fields
      []
    end

    def serializer
      nil
    end
  end
end