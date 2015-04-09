class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :active, :target, :departament_id, :picture, :picture_thumb, :organization_id

  has_one :departament, root: :team

  def picture
    object.avatar.url(:medium)
  end

  def picture_thumb
    object.avatar.url(:thumb)
  end
end
