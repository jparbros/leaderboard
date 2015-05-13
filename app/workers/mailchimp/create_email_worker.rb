module Mailchimp
  class CreateEmailWorker
    include Sidekiq::Worker

    def perform(email_id)
      email = Email.find email_id
      email.create_campaign
    end
  end
end
