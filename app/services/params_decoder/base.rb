module ParamsDecoder
  class Base

    attr_reader :params

    def initialize(params)
      @params = params.try(:deep_symbolize_keys) || params.deep_dup

      if @params[:base64_encoded] == "true"
        params_to_decode.each do |param|
          @params[param] = Base64Service.decode(@params[param])
        end
      end
    end

    def params_to_decode
      []
    end
  end
end