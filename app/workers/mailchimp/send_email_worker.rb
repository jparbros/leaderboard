module Mailchimp
  class SendEmailWorker
    include Sidekiq::Worker

    def perform(email_id)
      email = Email.find email_id
      email.send_campaign
    end
  end
end
