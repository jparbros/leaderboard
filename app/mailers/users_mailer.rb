class UsersMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers

  default from: "contact@rankingdesk.com"

  layout 'mailer'

  def new_user_notification(user, token)
    @email = EmailTemplate.find_by name: 'new_user_notification'
    subdomain = user.organization.subdomain
    body = Liquid::Template.parse(@email.body).render('user_name' => user.name, 'user_email' => user.email, 'token' => token, 'subdomain' => subdomain)
    mail(to: user.email, subject: @email.subject) do |format|
      format.html { render html: body.html_safe}
    end
  end

  def new_client_notification(user)
    @email = EmailTemplate.find_by name: 'new_client_notification'
    subdomain = user.organization.subdomain
    body = Liquid::Template.parse(@email.body).render('client_name' => user.name, 'client_email' => user.email, 'subdomain' => subdomain)
    mail(to: user.email, subject: @email.subject) do |format|
      format.html { render html: body.html_safe}
    end
  end

  def confirmation_instructions(record, token, opts={})
    super
  end

  def reset_password_instructions(record, token, opts={})
    @email = EmailTemplate.find_by name: 'reset_password_instructions'
    subdomain = record.organization.subdomain
    body = Liquid::Template.parse(@email.body).render('user_name' => record.name, 'user_email' => record.email, 'token' => token, 'subdomain' => subdomain)
    mail(to: record.email, subject: @email.subject) do |format|
      format.html { render html: body.html_safe}
    end
  end

  def unlock_instructions(record, token, opts={})
    super
  end
end
