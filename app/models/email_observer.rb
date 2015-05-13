class EmailObserver < ActiveRecord::Observer

  def after_create(email)
    Mailchimp::CreateEmailWorker.perform_async(email.id)
  end

  def after_update(email)
    Mailchimp::UpdateEmailWorker.perform_async(email.id)
  end
end
