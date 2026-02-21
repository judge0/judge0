class StatusesController < ApplicationController
  def index
    render json: Status.all, each_serializer: StatusSerializer
  end
end
