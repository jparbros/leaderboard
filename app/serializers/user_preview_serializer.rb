class UserPreviewSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :departament_name

  def departament_name
    object.departament.name
  end
end