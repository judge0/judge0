class LanguagesController < ApplicationController
  def index
    render json: Language.all, each_serializer: LanguageSerializer
  end
end
