class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at
end
