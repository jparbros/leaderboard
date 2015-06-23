class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :active, :days_left, :boardname, :rolling, :rolling_time, :name, :boardname, :subscribed
end
