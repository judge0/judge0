class CodesController < ApplicationController
    def index
        render json: Code.all, fields: [:id, :text]
    end
    
    def show
        render json: Code.unscoped.find(params[:id])
    end

    def create
      code = Code.new(code_params(params))
  
      if code.save
        render json: code, status: :created, fields: [:text]
      else
        render json: code.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def code_params(params)
      code_params = params.permit(
        :text
      )
    end
  end
  