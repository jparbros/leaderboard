module Api
  class InputsController < ApplicationController

    def index
      @inputs = organization.inputs
      @inputs = @inputs.by_today if params[:period] == 'today'
      @inputs = @inputs.by_week if params[:period] == 'week'
      @inputs = @inputs.by_month if params[:period] == 'month'
      @inputs = @inputs.by_quarter if params[:period] == 'quarter'
      @inputs = @inputs.by_year if params[:period] == 'year'
      @inputs = @inputs.by_departament(params[:departament_id]) if params[:departament_id]
      @inputs = @inputs.group_by_user if params[:group_by_user]
      if params[:group_by_user]
        render json: @inputs
      else
        respond_with @inputs
      end
    end

    def create
      @input = user.inputs.create input_params
      render json: @input
    end

    def update
      @input = user.inputs.find params[:id]
      if @input.update_attributes input_params
        respond_with @input
      else
        respond_with status: 500
      end
    end

    def destroy
      @input = user.inputs.find params[:id]
      if @input.destroy
        respond_with status: 200
      else
        respond_with status: 500
      end

    end

    private

    def organization
      @organization ||= Organization.find params[:organization_id]
    end

    def user
      @user ||= organization.users.find params[:user_id]
    end

    def input_params
      params.require(:input).permit(:date, :description, :value)
    end
  end

end
