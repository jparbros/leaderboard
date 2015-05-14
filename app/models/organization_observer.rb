class OrganizationObserver < ActiveRecord::Observer

  def after_create(organization)
    organization.create_default_data
  end
end
