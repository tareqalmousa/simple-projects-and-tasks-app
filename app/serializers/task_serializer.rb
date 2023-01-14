class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :created_at
end
