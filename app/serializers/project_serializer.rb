class ProjectSerializer < ActiveModel::Serializer
  attributes :title, :description, :created_at
end
