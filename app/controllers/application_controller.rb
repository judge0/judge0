class ApplicationController < SessionsController
  private

  def render_invalid_fields_error(fields, subject = nil)
    fields_str = ""
    fields.each do |field|
      fields_str << field.to_s << ", "
    end

    subject_str = " for #{subject}" if subject

    render json: { 
             error: "invalid fields#{subject_str}: [#{fields_str[0..-3]}]"
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
