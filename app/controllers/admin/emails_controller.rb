class Admin::EmailsController < Admin::BaseController

  def index
    @emails = Email.all
  end

  def edit
    @email = email
  end

  private

  def email
    Email.find params[:id]
  end

end
