class InfoController < ApplicationController
  @@license ||= File.read("LICENSE")
  @@isolate ||= `isolate --version`

  def system_info
    render json: SystemInfo.sys_info
  end

  def config_info
    render json: Config.config_info
  end

  def about
    render json: {
      version: ENV["JUDGE0_VERSION"],
      homepage: ENV["JUDGE0_HOMEPAGE"],
      source_code: ENV["JUDGE0_SOURCE_CODE"],
      maintainer: ENV["JUDGE0_MAINTAINER"]
    }
  end

  def version
    render plain: ENV["JUDGE0_VERSION"]
  end

  def license
    render plain: @@license
  end

  def isolate
    render plain: @@isolate
  end

end