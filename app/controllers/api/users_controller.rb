module Api
  class UsersController < ApplicationController

    def index
      @users = organization.users
      respond_with @users
    end

    def create
      @user = organization.users.new(user_params)
      @user.set_password
      @user.provider = "email"
      User.skip_callback("create", :after, :send_on_create_confirmation_instructions)
      if @user.save!
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @user.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }

        @user.save!

        render json: @user
      else
        respond_with status: 500
      end
    end

    def update
      @user = organization.users.find params[:id]
      if @user.update_attributes user_params
        respond_with @user
      else
        respond_with status: 500
      end
    end

    def show
      @user = organization.users.find params[:id]
      respond_with @user
    end

    private

    def organization
      @organization ||= Organization.find params[:organization_id]
    end

    def user_params
      params.require(:user).permit(:name, :email, :alias, :departament_id, :active, target: [:daily, :monthly, :quartly, :yearly])
    end
  end
end