class InfoController < ApplicationController
  def system_info
    render json: SystemInfo.sys_info
  end

  def config_info
    render json: Rails.configuration.api
  end

  def version
    render json: { version: ENV.fetch("JUDGE0_API_VERSION", "unknown") }
  end

  def statistics
    long_format = params[:long_format] == "true"

    groups = Submission.unscoped.group(:language_id, :status_id).count

    language_table = Language.all.map{ |l| [l.id, l.name] }.to_h
    status_table   = Status  .all.map{ |s| [s.id, s.name] }.to_h

    group_by_status = {}
    if long_format
      status_table.each do |k, v|
        group_by_status[v] = 0
      end
    end

    group_by_language = {}
    if long_format
      language_table.each do |k, v|
        group_by_language[v] = { total: 0, statuses: group_by_status.deep_dup }
      end
    end

    submission_count = 0
    groups.each do |k, v|
      submission_count += v

      group_by_status[status_table[k[1]]] ||= 0
      group_by_status[status_table[k[1]]]  += v

      group_by_language[language_table[k[0]]] ||= { total: 0, statuses: {} }

      group_by_language[language_table[k[0]]][:total] +=  v

      group_by_language[language_table[k[0]]][:statuses][status_table[k[1]]] ||= 0
      group_by_language[language_table[k[0]]][:statuses][status_table[k[1]]]  +=  v
    end

    render json: {
      submissions: submission_count,
      documents:   Document.count,
      test_cases:  TestCase.count,
      test_suites: TestSuite.count,
      statuses:    group_by_status,
      languages:   group_by_language
    }
  end
end
