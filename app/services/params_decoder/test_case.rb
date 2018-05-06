module ParamsDecoder
  class TestCase < Base
    def initialize(params, is_base64_encoded)
      super(params, is_base64_encoded)
    end

    def params_to_decode
      [:input, :output]
    end
  end
end