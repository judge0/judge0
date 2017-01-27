class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :status, :actual_output, :created_at, :finished_at, :time, :memory

  def status
    { id: object.status_id, description: object.status.name }
  end
end
