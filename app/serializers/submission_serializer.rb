class SubmissionSerializer < ActiveModel::Serializer
  attributes((Submission.column_names + ["status", "language"] - ["id"]).collect(&:to_sym))

  def self.default_fields
    @@default_fields ||= [
      :token,
      :time,
      :memory,
      :stdout,
      :stderr,
      :compile_output,
      :message,
      :status
    ]
  end

  def source_code
    object_decoder(:source_code)
  end

  def stdin
    object_decoder(:stdin)
  end

  def expected_output
    object_decoder(:expected_output)
  end

  def stdout
    object_decoder(:stdout)
  end

  def stderr
    object_decoder(:stderr)
  end

  def compile_output
    object_decoder(:compile_output)
  end

  def message
    if instance_options[:base64_encoded] and object.message
      return Base64Service.encode(object.message)
    end
    object.message
  end

  def status
    { id: object.status_id, description: object.status.name }
  end

  def language
    ActiveModelSerializers::SerializableResource.new(object.language, { serializer: LanguageSerializer, fields: [:id, :name] })
  end

  def additional_files
    Base64Service.encode(object.additional_files)
  end

  private

  def object_decoder(method)
    instance_options[:base64_encoded] ? object[method] : object.send(method)
  end
end
