module ParamsDecoder
  class Submission < Base
    def initialize(params, is_base64_encoded)
      super(params, is_base64_encoded)
    end

    def params_to_decode
      [:source_code, :stdin, :expected_output]
    end
  end
end