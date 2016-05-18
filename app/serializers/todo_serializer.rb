class TodoSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :user_id, :text, :done, :updated_at, :created_at
end
