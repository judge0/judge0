module ParamsDecoder
  class Base

    attr_reader :params

    def initialize(params, is_base64_encoded) # ActionController::Parameters
      @params = {}
      params.each do |k, v|
        k = k.to_sym
        if params_to_decode.include?(k) && is_base64_encoded
          @params[k] = Base64Service.decode(v)
        else
          @params[k] = v
        end
      end
    end

    def params_to_decode
      []
    end
  end
end