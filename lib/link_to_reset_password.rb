class LinkToResetPassword < Liquid::Tag
  include ActionView::Helpers::UrlHelper

  def initialize(tag_name, params, tokens)
    @routes = Rails.application.routes.url_helpers
    @params = params
    super
  end

  def render(context)
    vars = context.environments.first
    profile_url = Rails.application.routes.url_helpers.profile_url(subdomain: vars[:subdomain])
    host = Rails.application.config.action_mailer[:default_url_options][:host]
    link_to @params, @routes.edit_user_password_url(reset_password_token: vars[:token], subdomain: vars[:subdomain], redirect_url: profile_url,  only_path: true)
  end

end
