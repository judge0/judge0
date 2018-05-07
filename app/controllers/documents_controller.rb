class DocumentsController < ApplicationController
  before_action :authorize_request, only: [:index, :show]

  def index
    pagination_service = PaginationService.new(params)
    if pagination_service.has_invalid_page?
      render_invalid_page_error(pagination_service.page)
      return
    elsif pagination_service.has_invalid_per_page?
      render_invalid_per_page_error(pagination_service.per_page)
      return
    end

    render json: pagination_service.paginate(
                   Document,
                   DocumentSerializer,
                   {
                     base64_encoded: params[:base64_encoded] == "true"
                   }
                 )
  end

  def show
    render json:           Document.find_by(digest: params[:digest]),
           serializer:     DocumentSerializer,
           base64_encoded: params[:base64_encoded] == "true"
  end
end