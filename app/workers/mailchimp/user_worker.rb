module Mailchimp
  class UserWorker
    include Sidekiq::Worker

    def perform(user_id)
      user = User.find user_id
      user.update_mailchimp
    end
  end
end
