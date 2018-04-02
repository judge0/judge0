class InfoController < ApplicationController
  def system_info
    render json: SystemInfo.sys_info
  end

  def config_info
    render json: Rails.configuration.api
  end
end