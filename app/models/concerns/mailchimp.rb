module Mailchimp
  extend ActiveSupport::Concern

  def subscribe
    ::GB.lists.subscribe(
      { id: 'c798ed03ab',
        email: {
          email: email
        },
        merge_vars: {
          NAME: name
        },
        double_optin: false
      }
    )
  end

  def unsubscribe
    ::GB.lists.unsubscribe(
      id: 'c798ed03ab',
      email: {
        email: email
      },
      delete_member: true,
      send_notify: false
    )
  end

  def update_mailchimp
    if role != 'boardlogin'
      if newsletter
        subscribe
      else
        unsubscribe
      end
    end
  end
end