module Fields
  class Base

    attr_reader :fields, :invalid_fields

    def initialize(fields_str)
      fields = fields_str.to_s.split(",").collect(&:to_sym)
      
      @invalid_fields = []
      fields.each do |field|
        @invalid_fields << field unless serializer._attributes.include?(field)
      end

      @fields = fields.presence || default_fields
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