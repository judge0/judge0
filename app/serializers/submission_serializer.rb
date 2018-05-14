class SubmissionSerializer < ActiveModel::Serializer
  attributes(
    (
      Submission.column_names.reject{ |n| /^id$/.match(n) }.collect{ |n| n.gsub(/_id$/, "") } +
      ["test_suite_uuid", "results", "compile_command", "run_command", "tasks_before", "submissions_before"] - ["test_suite"]
    ).collect(&:to_sym)
  )

  def source
    encode(object.source)
  end

  def internal_message
    encode(object.internal_message)
  end

  def compile_output
    encode(object.compile_output)
  end

  def status
    ActiveModelSerializers::SerializableResource.new(object.status, { serializer: StatusSerializer })
  end

  def test_suite_uuid
    object.test_suite.uuid
  end

  def language
    ActiveModelSerializers::SerializableResource.new(object.language, { serializer: LanguageSerializer })
  end

  def compile_command
    object.language.compile_cmd
  end

  def run_command
    object.language.run_cmd
  end

  def tasks_before
    return 0 if object.status != Status.queue
    SubmissionResult
      .where(status_id: Status.queue)
      .where.not(submission: object)
      .where("submission_results.created_at < ?", object.created_at).count
  end

  def submissions_before
    return 0 if object.status != Status.queue
    Submission
      .where(status_id: Status.queue)
      .where.not(id: object)
      .where("submissions.created_at < ?", object.created_at).count
  end

  def results
    ActiveModelSerializers::SerializableResource.new(
      object.results,
      {
        each_serializer:  SubmissionResultSerializer,
        fields:           instance_options[:result_fields],
        test_case_fields: instance_options[:test_case_fields],
        base64_encoded:   instance_options[:base64_encoded]
      }
    ).as_json
  end

  private

  def encode(document)
    return nil unless document
    instance_options[:base64_encoded] ? Base64Service.encode(document.content) :
                                        document.content
  end
end
