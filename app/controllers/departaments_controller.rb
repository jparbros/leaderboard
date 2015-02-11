class DepartamentsController < ApplicationController

  def index
    @departaments = organization.departaments
    respond_with @departaments
  end

  def create
    @departament = organization.departaments.create departament_params
    render json: @departament
  end

  private

  def organization
    @organization ||= Organization.find params[:organization_id]
  end

  def departament_params
    params.require(:departament).permit(:name, period: [])
  end
end
