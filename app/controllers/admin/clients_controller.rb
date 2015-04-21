class Admin::ClientsController < Admin::BaseController

  def index
    @organizations = Organization.all
  end
end
