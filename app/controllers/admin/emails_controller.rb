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

  def create
    @email = Email.new email_params
    if @email.save
      redirect_to admin_emails_url
    else
      render :new
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
