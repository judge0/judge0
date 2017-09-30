class InfoController < ApplicationController
  def system_info
    render json: SystemInfo.sys_info
  end

  def config_info
    render json: Config.config_info
  end
end