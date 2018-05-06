class ApplicationController < SessionsController
  private

  def render_invalid_fields_error(fields)
    fields_str = ""
    fields.each do |field|
      fields_str << field.to_s << ", "
    end

    render json: { 
             error: "invalid fields: [#{fields_str[0..-3]}]"
           }, 
           status: :bad_request
  end

  def render_invalid_page_error(page)
    render json: { error: "invalid page: #{page}" }, status: :bad_request
  end

  def render_invalid_per_page_error(per_page)
    render json: { error: "invalid per_page: #{per_page}" }, status: :bad_request
  end
end
