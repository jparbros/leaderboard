class InputsController < ApplicationController

  def index
    @inputs = user.inputs
    respond_with @inputs
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

  def user
    @user ||= User.find(params[:user_id])
  end

  def input_params
    params.require(:input).permit(:date, :description, :value)
  end
end
