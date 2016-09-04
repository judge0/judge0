RSpec::Matchers.define :have_serialized do |unserialized|
  chain :with do |serializer|
    @serializer = serializer
  end

  chain :wrap do |collection_serializer|
    @collection_serializer = collection_serializer
  end

  def serialize(object)
    @collection_serializer ||= ActiveModel::Serializer::CollectionSerializer

    if object.respond_to?(:map)
      serializer = @collection_serializer.new(object, serializer: @serializer)
    else
      serializer = @serializer.new(object)
    end

    json = ActiveModelSerializers::Adapter::JsonApi.new(serializer).to_json
    JSON.parse(json)
  end

  match do |serialized|
    serialized == serialize(unserialized)
  end

  failure_message do |serialized|
    <<-FAIL.strip_heredoc
    expected:
    #{serialized}
    to match:
    #{serialize(unserialized)}
    ---
    #{inspect}
    FAIL
  end

  failure_message_when_negated do |serialized|
    <<-FAIL.strip_heredoc
    expected
    #{serialized}
    not to match:
    #{serialize(unserialized)}
    ---
    #{inspect}
    FAIL
  end

  def inspect
    <<-INSPECT.strip_heredoc
    Using object serializer: #{@serializer}
    Using collection serializer: #{@collection_serializer}
    INSPECT
  end
end
