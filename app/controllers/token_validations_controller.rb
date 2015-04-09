class TokenValidationsController < DeviseTokenAuth::ApplicationController

  def validate_token
    @user = set_user_by_token
    if @user
      render json: {
        data: @user.token_validation_response
      }
    else
      render json: {
        success: false,
        errors: ["Invalid login credentials"]
      }, status: 401
    end
  end
end
