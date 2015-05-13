module Mailchimp
  class UpdateEmailWorker
    include Sidekiq::Worker

    def perform(email_id)
      email = Email.find email_id
      email.update_campaign
    end
  end
end
