class TaskSerializer < ActiveModel::Serializer
  attributes :title, :status, :created_at
end
