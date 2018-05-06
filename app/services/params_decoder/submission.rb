module ParamsDecoder
  class Submission < Base
    def initialize(params)
      super(params)
    end

    def params_to_decode
      [:source_code, :stdin, :expected_output]
    end
  end
end