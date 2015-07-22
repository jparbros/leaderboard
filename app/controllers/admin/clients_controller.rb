class Admin::ClientsController < Admin::BaseController

  def index
    params[:order] ||= 'id DESC'
    @organizations = Organization.order(params[:order]).includes(:subscription)
  end

  def become
    @user = User.find(params[:client_id])

    if @user
      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token     = SecureRandom.urlsafe_base64(nil, false)

      @user.tokens[@client_id] = {
        token: BCrypt::Password.create(@token),
        expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
      }
      @user.save!

      sign_in(:user, @user, store: false, bypass: false)

      redirect_to input_url(
        subdomain:      @user.organization.subdomain,
        token:          @token,
        client_id:      @client_id,
        uid:            @user.uid
      )
    else
      redirect_to admin_clients_url
    end
  end
end
