module Admin::BaseHelper

  def clients_active_menu
    controller_name == 'clients' ? 'active' : ''
  end

  def emails_active_menu
    controller_name == 'emails' ? 'active' : ''
  end

  def email_templates_active_menu
    controller_name == 'email_templates' ? 'active' : ''
  end
end
