module Api
  class DepartamentsController < ApplicationController

    def index
      @departaments = organization.departaments
      respond_with @departaments
    end

    def create
      if @departament = organization.departaments.create(departament_params)
        render json: @departament
      else
        render json: @departament.errors.full_messages, status: 500
      end
    end

    def update
      @departament = organization.departaments.find params[:id]
      if @departament.update_attributes departament_params
        respond_with @departament
      else
        render json: @departament.errors.full_messages, status: 500
      end
    end

    def destroy
      @departament = organization.departaments.find params[:id]
      if @departament.destroy
        respond_with status: 200
      else
        render json: @departament.errors.full_messages, status: 500
      end

    end

    def show
      @departament = organization.departaments.find params[:id]
      respond_with @departament
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
