class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :active, :target, :departament_id

  has_one :departament, root: :team

end
