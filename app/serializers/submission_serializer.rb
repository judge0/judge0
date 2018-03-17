class SubmissionSerializer < ActiveModel::Serializer
  attributes((Submission.column_names.reject{ |n| /id$/.match(n) } + Submission.column_names.reject{ |n| /.+id$/.match(n).nil? }.collect{ |n| n.gsub(/_id$/, "") } + ["source_code"]).collect(&:to_sym))

  def source_code
    source
  end

  def source
    object_decoder(object.source)
  end

  def stdin
    object_decoder(object.stdin)
  end

  def expected_output
    object_decoder(object.expected_output)
  end

  def stdout
    object_decoder(object.stdout)
  end

  def stderr
    object_decoder(object.stderr)
  end

  def compile_output
    object_decoder(object.compile_output)
  end
  
  def message
    object_decoder(object.message)
  end

  def status
    { id: object.status_id, description: Status.find_by(id: object.status_id).name }
  end

  def language
    ActiveModelSerializers::SerializableResource.new(object.language, { serializer: LanguageSerializer })
  end

  private

  def object_decoder(document)
    return nil unless document
    instance_options[:base64_encoded] ? Base64Service.encode(document.content) : document.content
  end
end
