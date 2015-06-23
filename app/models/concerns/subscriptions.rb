module Subscriptions
  extend ActiveSupport::Concern

  def subscribe
    subscription = create_subscription
    self.active_until = period_active_until(subscription)
    self.organization.subscribed = true
    self.subscription_id = subscription.id
    self.save!
    self.organization.save!
  end

  private

  def create_subscription
    Stripe::Customer.create(
      :source => token,
      :plan => subscription_plan,
      :email => organization.owner.email
    )
  end

  def period_active_until(subscription)
    Time.at(subscription.subscriptions.data.first.current_period_end)
  end
end