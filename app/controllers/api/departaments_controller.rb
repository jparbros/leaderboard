module Api
  class DepartamentsController < ApplicationController

    def index
      @departaments = organization.departaments
      respond_with @departaments
    end

    def create
      @departament = organization.departaments.create departament_params
      render json: @departament
    end

    def update
      @departament = organization.departaments.find params[:id]
      if @departament.update_attributes departament_params
        respond_with @departament
      else
        respond_with status: 500
      end
    end

    def destroy
      @departament = organization.departaments.find params[:id]
      if @departament.destroy
        respond_with status: 200
      else
        respond_with status: 500
      end

    end

    private

    def organization
      @organization ||= Organization.find params[:organization_id]
    end

    def departament_params
      params.require(:departament).permit(:name, period: [])
    end
  end

end
