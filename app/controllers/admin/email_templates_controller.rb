class Admin::EmailTemplatesController < Admin::BaseController

  def index
    @emails = EmailTemplate.all
  end

  def edit
    @email = EmailTemplate.find params[:id]
  end

  def update
    @email = EmailTemplate.find params[:id]
    if @email.update_attributes email_params
      redirect_to admin_email_templates_url
    else
      render :edit
    end
  end

  private

  def email_params
    params.require(:email_template).permit(:name, :subject, :body)
  end
end
