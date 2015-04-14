class InputSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :value, :created_at

  has_one :user, serializer: UserPreviewSerializer
end
