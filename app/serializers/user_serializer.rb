class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :name, :active, :target, :departament_id, :picture, :picture_thumb, :organization_id, :uid, :role, :newsletter, :alias

  has_one :departament, root: :team

  def picture
    object.avatar.url(:medium)
  end

  def picture_thumb
    object.avatar.url(:thumb)
  end

  def username
    object.name || object.uid || object.email
  end
end
