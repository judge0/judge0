class HomeController < ActionController::API
  include ActionView::Layouts

  def docs
    render file: Rails.root.join('public/docs.html')
  end
end
