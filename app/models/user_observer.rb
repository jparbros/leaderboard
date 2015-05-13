class UserObserver < ActiveRecord::Observer

  def after_save(user)
    Mailchimp::UserWorker.perform_async(user.id)
  end
end
