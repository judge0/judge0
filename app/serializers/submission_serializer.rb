class SubmissionSerializer < ActiveModel::Serializer
  attributes(
    (
      Submission.column_names.reject{ |n| /^id$/.match(n) }.collect{ |n| n.gsub(/_id$/, "") } +
      ["test_suite_uuid", "results"] - ["test_suite"]
    ).collect(&:to_sym)
  )

  belongs_to :language, serializer: LanguageSerializer

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
    { id: object.status.id, description: object.status.name }
  end

  def test_suite_uuid
    object.test_suite.uuid
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
