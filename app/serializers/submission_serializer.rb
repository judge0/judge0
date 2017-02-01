class SubmissionSerializer < ActiveModel::Serializer
  attributes :token, :status, :stdout, :stderr, :created_at, :finished_at, :time, :memory

  def status
    { id: object.status_id, description: object.status.name }
  end
end
