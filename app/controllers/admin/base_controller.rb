class Admin::BaseController < ActionController::Base
  before_filter :authenticate_admin!

  respond_to :html

  layout 'admin'
end
