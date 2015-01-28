class OrganizationsController < ApplicationController

  def show
    @organization = Organization.find params[:id]
    respond_with @organization
  end

end
