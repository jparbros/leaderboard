class Api::SubdomainsController < ApplicationController

  def forgot
    @user = User.find_by uid: params[:email]
    if @user
      render json: { subdomain: @user.organization.subdomain }
    else
      render json: {error: 'Not Found'}, status: 404
    end
  end

end
