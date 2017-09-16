class HomeController < ApplicationController
  include ActionView::Layouts

  skip_before_action :authenticate_request, only: :docs

  def docs
    render file: Rails.root.join('public/docs.html')
  end
end
