module ParamsDecoder
  class TestSuite
    
    attr_reader :params

    def initialize(params, is_base64_encoded) # [ActionController::Parameters ...]
      @params = []
      params.each do |param|
        @params << ParamsDecoder::TestCase.new(param, is_base64_encoded).params
      end
    end
  end
end