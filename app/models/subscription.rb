class Subscription < ActiveRecord::Base

  has_many :transactions

  attr_accessor :credit_card_attributes, :billing_address

  before_save :store_credit_card

  YEARLY_DESCRIPTION = "RankingDesk Yearly Subscription €89"
  MONTHLY_DESCRIPTION = "RankingDesk Monthly Subscription €99"
  CURRENCY = 'EUR'
  MONTHLY_COST_CENTS = 9900
  YEARLY_COST_CENTS = 106800

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(credit_card_attributes)
  end

  def description
    (subscription_kind == 'yearly') ? YEARLY_DESCRIPTION : MONTHLY_DESCRIPTION
  end

  private

  def store_credit_card
    if credit_card_attributes
      response = ::GATEWAY.store(credit_card, store_options)
      if response.success?
        self.transacion_number = response.params['transaction']
        self.card_number = response.params['cardnumber']
        self.card_type = response.params['cardtype']
      else
        raise CreditCardException, "There was an error saving the credit card"
      end
    end
  end

  def store_options
    generate_store_order_number
    {description: description, currency: CURRENCY, order_id: order_number}
  end

  def generate_store_order_number
    possible = (0..9).to_a
    self.order_number = "C" + (0..3).map { possible.shuffle.first}.join
  end

  def subscription_cost
    (subscription_kind == 'yearly') ? YEARLY_COST_CENTS : MONTHLY_COST_CENTS
  end

  def generate_purchase_order_number
    possible = (0..9).to_a
    "S" + (0..3).map { possible.shuffle.first}.join
  end

  def purchase_options
    {order_id: generate_purchase_order_number}
  end

  def process_payment
    response = ::GATEWAY.purchase(subscription_cost, transacion_number, purchase_options)
    self.transactions.create transaction_params(response)
  end

  def transaction_params(response)
    { transacion_number: response.params['transaction'],
      authorization_number: response.authorization,
      amount_cents: response.params['amount'],
      currency: response.params['currency'],
      order_number: response.params['ordernumber'],
      success: response.success?,
      message: response.message }
  end

end

class CreditCardException < StandardError
end