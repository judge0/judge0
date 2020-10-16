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

  def statistics
    Rails.cache.delete("statistics") if params[:invalidate_cache] == "true"
    @@cache_duration ||= 10.minutes
    render json: Rails.cache.fetch("statistics", expires_in: @@cache_duration) {
      @@language_name ||= Hash[Language.unscoped.pluck(:id, :name)]

      count_by_language = []
      Submission.unscoped.group(:language_id).count.each do |language_id, count|
        count_by_language << {
          language: {
            id: language_id,
            name: @@language_name[language_id]
          },
          count: count
        }
      end
      count_by_language = count_by_language.sort_by { |x| x[:count] }.reverse

      count_by_status = []
      Submission.unscoped.group(:status_id).count.each do |status_id, count|
        count_by_status << {
          status: {
            id: status_id,
            name: Status.find_by(id: status_id).name # Not a SQL query!
          },
          count: count
        }
      end
      count_by_status = count_by_status.sort_by{ |x| x[:count] }.reverse

      now = DateTime.now
      today = DateTime.now.beginning_of_day.to_date
      last_30_days = Submission.unscoped.group("created_at::DATE").where("created_at::DATE >= ?", today - 30).count
      last_30_days[today] ||= 0
      last_30_days_result = {}
      (today-30...today).each do |day|
        last_30_days_result[day.to_date] = last_30_days[day] || 0
      end
      last_30_days_result = last_30_days_result.sort.reverse.to_h

      database_size = ActiveRecord::Base.connection.execute(
        "SELECT
          pg_size_pretty(pg_database_size('#{ENV['POSTGRES_DB']}')) AS size_pretty,
          pg_database_size('#{ENV['POSTGRES_DB']}') AS size_in_bytes
        "
      ).to_a[0]

      {
        created_at: now,
        cached_until: now + @@cache_duration,
        submissions: {
          total: Submission.count,
          today: last_30_days[today],
          last_30_days: last_30_days_result
        },
        languages: count_by_language,
        statuses: count_by_status,
        database: {
          size_pretty: database_size["size_pretty"],
          size_in_bytes: database_size["size_in_bytes"]
        }
      }
    }
  end
end