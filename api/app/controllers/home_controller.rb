class HomeController < ApplicationController
  include ActionView::Layouts

  def docs
    render file: Rails.root.join('public/docs.html')
  end
end
