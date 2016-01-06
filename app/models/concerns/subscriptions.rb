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

  def recurring_subscription(data)
    self.active_until = Time.at(data['current_period_end'])
    self.organization.subscribed = data['status'] == 'active'
    self.save!
    self.organization.save!
  end

  def create_transaction(data)
    self.transactions.create(
      transacion_number: data['balance_transaction'],
      amount_cents: data['amount'],
      currency: data['currency'],
      success: true
    )
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