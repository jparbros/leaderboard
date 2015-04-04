module Api
  class OrganizationsController < ApplicationController

    def show
      @organization = Organization.find params[:id]
      respond_with @organization
    end

    def availability
      render json: Organization.availability(params[:subdomain])
    end

  end
end
