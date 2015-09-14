class InputSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :value, :created_at

  has_one :user, serializer: UserPreviewSerializer

  def value
    ActiveSupport::NumberHelper.number_to_delimited(('%.2f' % object.value), delimiter: ' ', separator: ',')
  end
end
