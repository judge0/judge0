class SubmissionResultSerializer < ActiveModel::Serializer
  attributes(
    (
      SubmissionResult.column_names.reject{ |n| /^id$/.match(n) }.collect{ |n| n.gsub(/_id$/, "") } +
      ["test_case_uuid"] - ["submission"]
    ).collect(&:to_sym)
  )

  def stdout
    encode(object.stdout)
  end

  def stderr
    encode(object.stderr)
  end

  def compile_output
    encode(object.compile_output)
  end

  def sandbox_message
    encode(object.sandbox_message)
  end

  def internal_message
    encode(object.internal_message)
  end

  def status
    ActiveModelSerializers::SerializableResource.new(object.status, { serializer: StatusSerializer })
  end

  def test_case_uuid
    object.test_case.uuid
  end

  def test_case
    ActiveModelSerializers::SerializableResource.new(
      object.test_case,
      {
        serializer:     TestCaseSerializer,
        fields:         instance_options[:test_case_fields],
        base64_encoded: instance_options[:base64_encoded]
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