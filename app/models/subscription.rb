class Subscription < ActiveRecord::Base

  has_many :transactions
  belongs_to :organization

  YEARLY_DESCRIPTION = "RankingDesk Yearly Subscription €89"
  MONTHLY_DESCRIPTION = "RankingDesk Monthly Subscription €99"

  before_save :cart_type_downcase

  include Subscriptions

  def description
    (subscription_kind == 'yearly') ? YEARLY_DESCRIPTION : MONTHLY_DESCRIPTION
  end

  def active
    active_until >= Time.now
  end

  private

  def cart_type_downcase
    self.card_type = self.card_type.downcase if card_type
  end

  def subscription_plan
    (subscription_kind == 'yearly') ? 'RDYEAR' : 'RDMONTH'
  end

end