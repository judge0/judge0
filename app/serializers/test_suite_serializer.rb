class TestSuiteSerializer < ActiveModel::Serializer
  attributes :uuid, :test_cases

  def test_cases
    ActiveModelSerializers::SerializableResource.new(
      object.test_cases,
      {
        each_serializer: TestCaseSerializer,
        fields:          instance_options[:test_case_fields],
        base64_encoded:  instance_options[:base64_encoded]
      }
    ).as_json
  end
end
