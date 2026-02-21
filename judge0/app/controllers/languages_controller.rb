class LanguagesController < ApplicationController
  def index
    render json: Language.all, each_serializer: LanguageSerializer, fields: [:id, :name]
  end

  def all
    render json: Language.unscoped.order(name: :asc), each_serializer: LanguageSerializer, fields: [:id, :name, :is_archived]
  end

  def show
    render json: Language.unscoped.find(params[:id])
  end
end
