class ApplicationController < ActionController::API
  def system_info
    render json: SystemInfo.sys_info
  end

  def default_config
    render json: Config.default_config
  end
end
