class Admin::EmailsController < Admin::BaseController

  def index
    @emails = Email.all
  end

  def edit
    @email = email
  end

  def new
    @email = Email.new
  end

  def show
    @email = email
    @email.sent_total = GB.reports.sent_to({cid: @email.mailchimp_id})['total']
    @email.opened_total = GB.reports.opened({cid: @email.mailchimp_id})['total']
  end

  def create
    @email = Email.new email_params
    if @email.save
      redirect_to admin_emails_url
    else
      render :new
    end
  end

  def update
    @email = email
    if @email.update_attributes email_params
      redirect_to admin_emails_url
    else
      render :edit
    end
  end

  private

  def email
    Email.find params[:id]
  end

  def email_params
    params.require(:email).permit(:name, :subject, :body)
  end

end
