class Api::GuestUsersController < ApplicationController

  def show
    render json: organization.guest_user
  end

  def create
    @user = organization.users.new(guest_user_params)
    User.skip_callback("create", :after, :send_on_create_confirmation_instructions)

    if @user.save
      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token     = SecureRandom.urlsafe_base64(nil, false)

      @user.tokens[@client_id] = {
        token: BCrypt::Password.create(@token),
        expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
      }

      @user.save!

      render json: @user
    else
      render json: @user.errors.full_messages, status: 500
    end
  end

  def update
    @user = organization.guest_user
    if @user.update_attributes guest_user_params
      render json: @user
    else
      render json: @user.errors.full_messages, status: 500
    end
  end

  private

  def organization
    @organization ||= Organization.find params[:organization_id]
  end

  def guest_user_params
    params.require(:guest_user).permit(
      :uid,
      :password,
      :password_confirmation).merge({
        provider: 'username',
        role: 'boardlogin',
        email: "#{params[:guest_user][:uid]}@boardlogin.rankingdesk.com"})
  end

end
