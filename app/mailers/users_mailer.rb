class UsersMailer < ActionMailer::Base
  default from: "contact@rankingdesk.com"

  layout 'mailer'

  def new_user_notification(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to RankingDesk')
  end
end
