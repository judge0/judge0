class TestCaseSerializer < ActiveModel::Serializer
  attributes :uuid, :input, :output

  def input
    encode(object.input)
  end

  def output
    encode(object.output)
  end

  private
  
  def encode(document)
    return nil unless document
    instance_options[:base64_encoded] ? Base64Service.encode(document.content) :
                                        document.content
  end
end
