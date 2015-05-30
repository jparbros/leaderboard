module Api
  class InputsController < ApplicationController

    def index
      @inputs = organization.inputs.search(params)
      leader = @inputs.get_leader if params[:get_leader]
      if params[:group_by_user]
        if params[:get_leader]
          render json: leader
        else
          render json: @inputs
        end
      else
        if params[:page]
          render json: {
            current_page: @inputs.current_page,
            per_page: @inputs.per_page,
            total_entries: @inputs.total_entries,
            total_pages: @inputs.total_pages,
            entries: @inputs.map {|input| InputSerializer.new(input).as_json(root: false)}
          }
        else
          respond_with @inputs
        end
      end
    end

    def create
      if @input = user.inputs.create(input_params)
        render json: @input
      else
        render json: @input.errors.full_messages, status: 500
      end
    end

    def update
      @input = user.inputs.find params[:id]
      if @input.update_attributes input_params
        respond_with @input
      else
        render json: @input.errors.full_messages, status: 500
      end
    end

    def destroy
      @input = user.inputs.find params[:id]
      if @input.destroy
        respond_with status: 200
      else
        render json: @input.errors.full_messages, status: 500
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
