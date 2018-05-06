module ParamsDecoder
  class TestCase < Base
    def initialize(params)
      super(params)
    end

    def params_to_decode
      [:input, :output]
    end
  end
end