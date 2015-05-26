class LinkToResetPassword < Liquid::Tag
  include ActionView::Helpers::UrlHelper

  def initialize(tag_name, params, tokens)
    @params = params
    super
  end

  def render(context)
    vars = context.environments.first
    host = Rails.application.config.action_mailer[:default_url_options][:host]
    link_to @params, "http://#{vars[:subdomain]}.#{host}/auth/password/edit?redirect_url=http://#{vars[:subdomain]}.#{host}/profile&reset_password_token=#{vars[:token]}"
  end

end
