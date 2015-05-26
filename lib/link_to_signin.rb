class LinkToSignin < Liquid::Tag

  def initialize(tag_name, params, tokens)
    @params = params
    super
  end

  def render(context)
    vars = context.environments.first
    profile_url = Rails.application.routes.url_helpers.profile_url(subdomain: vars[:subdomain])
    host = Rails.application.config.action_mailer[:default_url_options][:host]
    link_to @params, "http://#{vars[:subdomain]}.#{host}/signin"
  end

end
