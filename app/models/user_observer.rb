class UserObserver < ActiveRecord::Observer

  def after_save(user)
    Mailchimp::UserWorker.perform_async(user.id)
  end

  def after_create(user)
    UsersMailer.new_client_notification(user).deliver if user.owner
  end
end
