class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :actual_output, :status, :time, :memory
end
