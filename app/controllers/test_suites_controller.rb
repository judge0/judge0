class TestSuitesController < ApplicationController
  before_action :authorize_request, only: [:index]

  def index
    if params[:fields] == "*"
      params[:test_suite_fields] ||= "*"
      params[:test_case_fields]  ||= "*"
    end

    test_suite_fields = Fields::TestSuite.new(params[:test_suite_fields])
    if test_suite_fields.has_invalid_fields?
      render_invalid_fields_error(test_suite_fields.invalid_fields, "test suite")
      return
    end

    test_case_fields = Fields::TestCase.new(params[:test_case_fields], [:uuid])
    if test_case_fields.has_invalid_fields?
      render_invalid_fields_error(test_case_fields.invalid_fields, "test case")
      return
    end

    pagination_service = PaginationService.new(params)
    if pagination_service.has_invalid_page?
      render_invalid_page_error(pagination_service.page)
      return
    elsif pagination_service.has_invalid_per_page?
      render_invalid_per_page_error(pagination_service.per_page)
      return
    end

    render json: pagination_service.paginate(
                   TestSuite,
                   TestSuiteSerializer,
                   {
                     base64_encoded:   params[:base64_encoded] == "true",
                     fields:           test_suite_fields.fields,
                     test_case_fields: test_case_fields.fields
                   }
                 )
  end

  def show
    if params[:fields] == "*"
      params[:test_suite_fields] ||= "*"
      params[:test_case_fields]  ||= "*"
    end

    test_suite_fields = Fields::TestSuite.new(params[:test_suite_fields])
    if test_suite_fields.has_invalid_fields?
      render_invalid_fields_error(test_suite_fields.invalid_fields, "test suite")
      return
    end

    test_case_fields = Fields::TestCase.new(params[:test_case_fields], [:uuid])
    if test_case_fields.has_invalid_fields?
      render_invalid_fields_error(test_case_fields.invalid_fields, "test case")
      return
    end

    render json:             TestSuite.find_by!(uuid: params[:uuid]),
           serializer:       TestSuiteSerializer,
           base64_encoded:   params[:base64_encoded] == "true",
           fields:           test_suite_fields.fields,
           test_case_fields: test_case_fields.fields
  end

  def create
    if params[:fields] == "*"
      params[:test_suite_fields] ||= "*"
      params[:test_case_fields]  ||= "*"
    end

    test_suite_fields = Fields::TestSuite.new(params[:test_suite_fields])
    if test_suite_fields.has_invalid_fields?
      render_invalid_fields_error(test_suite_fields.invalid_fields, "test suite")
      return
    end

    test_case_fields = Fields::TestCase.new(params[:test_case_fields], [:uuid])
    if test_case_fields.has_invalid_fields?
      render_invalid_fields_error(test_case_fields.invalid_fields, "test case")
      return
    end

    test_suite_params_decoder = ParamsDecoder::TestSuite.new(params[:_json], params[:base64_encoded] == "true")
    test_suite = Builder::TestSuite.find_or_create(test_suite_params_decoder.params)

    render json:             test_suite,
           status:           :created,
           serializer:       TestSuiteSerializer,
           base64_encoded:   params[:base64_encoded] == "true",
           fields:           test_suite_fields.fields,
           test_case_fields: test_case_fields.fields
  end
end