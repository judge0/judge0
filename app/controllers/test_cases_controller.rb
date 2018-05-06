class TestCasesController < ApplicationController
  before_action :authorize_request, only: [:index]

  def index
    test_case_fields = Fields::TestCase.new(params[:fields])

    if test_case_fields.has_invalid_fields?
      render_invalid_fields_error(test_case_fields.invalid_fields)
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
                   TestCase, 
                   TestCaseSerializer,
                   {
                     base64_encoded: params[:base64_encoded] == "true", 
                     fields:         test_case_fields.fields
                   }
                 )
  end

  def show
    test_case_fields = Fields::TestCase.new(params[:fields])

    if test_case_fields.has_invalid_fields?
      render_invalid_fields_error(test_case_fields.invalid_fields)
    else
      render json:           TestCase.find_by!(uuid: params[:uuid]),
             serializer:     TestCaseSerializer,
             base64_encoded: params[:base64_encoded] == "true",
             fields:         test_case_fields.fields
    end
  end

  def create
    test_case_params_decoder = ParamsDecoder::TestCase.new(params)
    test_case = Builder::TestCase.find_or_create(test_case_params_decoder.params)

    render json:       test_case, 
           status:     :created, 
           serializer: TestCaseSerializer, 
           fields:     [:uuid]
  end
end
