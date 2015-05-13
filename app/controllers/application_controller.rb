class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :subdomain_exist?
  devise_group :admin, contains: [:admin]

  respond_to :json, :html

  layout :layout_by_resource

  def default_serializer_options
    {root: false}
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :newsletter
    devise_parameter_sanitizer.for(:account_update) << {organization_attributes: [:name]}
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :role
    devise_parameter_sanitizer.for(:sign_up) << :owner
    devise_parameter_sanitizer.for(:sign_up) << {organization_attributes: [:name, :subdomain]}
  end

  def subdomain_exist?
    if Subdomain.matches?(request)
      organization = Organization.find_by subdomain: request.subdomain
      redirect_to root_url(subdomain: false) unless organization || Subdomain.assets?(request)
    elsif Subdomain.admin?(request)
      redirect_to '/admin' unless devise_controller?
    end
  end

  def layout_by_resource
    if devise_controller?  && resource_name == :admin
      "admin"
    else
      "application"
    end
  end
end
