class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :card_number, :card_type, :subscription_kind, :description
end
