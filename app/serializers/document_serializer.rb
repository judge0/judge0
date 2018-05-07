class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :digest, :created_at, :content

  def content
    instance_options[:base64_encoded] ? Base64Service.encode(object.content) : object.content
  end
end