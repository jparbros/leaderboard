module Api
  class UsersController < ApplicationController

    respond_to :json

    def index
      @users = organization.users.where.not(role: 'boardlogin')
      @users = @users.where(departament_id: params[:departament_id]).order('id DESC') if params[:departament_id]
      respond_with @users
    end

    def create
      @user = organization.users.new(user_params)
      @user.set_password
      @user.provider = "email"
      @user.role = "user" if user_params[:role].nil? || user_params[:role].empty?
      User.skip_callback("create", :after, :send_on_create_confirmation_instructions)

      if @user.save
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @user.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }

        @user.save

        token = @user.create_password_token_reset
        if @user.owner
          UsersMailer.new_client_notification(user).deliver
        else
          UsersMailer.new_user_notification(@user, token).deliver
        end

        render json: @user.errors, location: api_users_url
      else
        render json: @user.errors, status: 500
      end
    end

    def update
      @user = organization.users.find params[:id]
      if @user.update_attributes user_params
        respond_with @user
      else
        render json: @user.errors.full_messages, status: 500
      end
    end

    def show
      @user = organization.users.find params[:id]
      respond_with @user
    end

    def upload
      user.avatar = params[:file]
      if user.save
        render json: @user
      else
        render json: @user.errors.full_messages, status: 500
      end
    end

    def resubmit_email
      token = user.create_password_token_reset
      UsersMailer.new_user_notification(@user, token).deliver
      render nothing: true, status: 200
    end

    private

    def organization
      @organization ||= Organization.find params[:organization_id]
    end

    def user_params
      params.require(:user).permit(:name, :email, :alias, :departament_id, :active, :role, target: [:daily, :weekly, :monthly, :quarterly, :yearly], organization_attributes: [:name, :vat])
    end

    def user
      @user ||= User.find params[:user_id]
    end
  end
end