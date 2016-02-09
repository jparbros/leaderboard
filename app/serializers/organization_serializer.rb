class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :active, :days_left, :boardname, :rolling, :rolling_time, :name, :boardname, :subscribed, :vat, :company_name, :billing_email
  has_one :address
end
