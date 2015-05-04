module Api
  class OrganizationsController < ApplicationController

    def show
      @organization = Organization.find params[:id]
      respond_with @organization
    end

    def availability
      render json: Organization.availability(params[:subdomain_to_check])
    end

    def update
      @organization = Organization.find params[:id]
      if @organization.update_attributes organization_params
        respond_with @organization
      else
        render json: @organization.errors.full_messages, status: 500
      end
    end

    private

    def organization_params
      params.require(:organization).permit(:boardname)
    end

  end
end
