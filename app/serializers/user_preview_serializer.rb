class UserPreviewSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :departament_name, :newsletter

  def departament_name
    object.departament.try(:name)
  end
end