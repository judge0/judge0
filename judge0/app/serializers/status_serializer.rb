class StatusSerializer < ActiveModel::Serializer
  attribute(:id) { object.id }
  attribute(:description) { object.name }
end
