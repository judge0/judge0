module NilValue
    def self.value_or_default(value, default)
        return value unless value == nil
        return default
    end
end