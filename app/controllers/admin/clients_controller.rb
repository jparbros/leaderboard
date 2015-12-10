class Admin::ClientsController < Admin::BaseController

  def index
    params[:order] ||= 'id DESC'
    @organizations = Organization.order(params[:order]).includes(:subscription)
  end

  def destroy
    organization = Organization.find params[:id]
    customer = Stripe::Customer.retrieve(organization.subscription.subscription_id)
    customer.subscriptions.retrieve(customer.subscriptions.first.id).delete
    redirect_to :index
  end

  def update
    organization = Organization.find params[:id]
    if organization.subscription.update_attributes(subscription_params)
      flash[:message] = 'Organization updated successfully'
    else
      flash[:message] = 'There was an erro updating organization'
    end
    redirect_to admin_clients_url
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

  private

  def subscription_params
    params.require(:subscription).permit(:active_until)
  end
end
