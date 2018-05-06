module Builder
  class TestCase
    def self.find_or_create(params)
      params = params.try(:deep_symbolize_keys) || params
      return ::TestCase.find_by(uuid: params[:test_case_uuid]) if params[:test_case_uuid]
      ::TestCase.find_or_create_by(
        input:  Document.find_or_create_with_content(params[:input]),
        output: Document.find_or_create_with_content(params[:output])
      )
    end

    def self.find_or_initialize(params)
      params = params.try(:deep_symbolize_keys) || params
      return ::TestCase.find_by(uuid: params[:test_case_uuid]) if params[:test_case_uuid]
      ::TestCase.find_or_initialize_by(
        input:  Document.find_or_initialize_with_content(params[:input]),
        output: Document.find_or_initialize_with_content(params[:output])
      )
    end
  end
end