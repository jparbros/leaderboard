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
      if address_params
        @organization.build_address unless @organization.address
        @organization.address.attributes = address_params
      end
      if @organization.update_attributes organization_params
        respond_with @organization
      else
        render json: @organization.errors.full_messages, status: 500
      end
    end

    private

    def organization_params
      params.require(:organization).permit(:boardname, :rolling, :rolling_time, :name, :vat)
    end

    def address_params
      return false unless params[:address_attributes]
      params[:address_attributes][:country_code] = params[:address_attributes][:country][:alpha_2_code]
      params[:address_attributes][:region_code] = params[:address_attributes][:region][:code]
      params.require(:address_attributes).permit(:address, :address_2, :country_code, :city, :zip_code, :region_code)
    end

  end
end
