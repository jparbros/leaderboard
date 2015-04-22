class Admin::ClientsController < Admin::BaseController

  def index
    @organizations = Organization.all
  end

  def become
    # return unless current_user.is_an_admin?
    sign_in(:user, User.find(params[:client_id]))
    redirect_to input_url(subdomain: 'demo')
  end
end
