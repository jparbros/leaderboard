class UsersMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers

  default from: "contact@rankingdesk.com"

  layout 'mailer'

  def new_user_notification(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: 'Welcome to RankingDesk')
  end

  def confirmation_instructions(record, token, opts={})
    super
  end

  def reset_password_instructions(record, token, opts={})
    super
  end

  def unlock_instructions(record, token, opts={})
    super
  end
end
