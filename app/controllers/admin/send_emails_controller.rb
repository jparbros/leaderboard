class Admin::SendEmailsController < Admin::BaseController

  def create
    email = Email.find params[:email_id]
    Mailchimp::SendEmailWorker.perform_async(email.id)
    redirect_to admin_emails_url
  end
end
