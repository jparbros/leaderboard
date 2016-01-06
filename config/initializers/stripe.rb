Stripe.api_key = "sk_test_mZww9eF34Na4z1kZz2E6Y9Of"

StripeEvent.subscribe 'charge.succeeded' do |event|
  params = event.data.object
  puts "PARAMS -> #{params}"
  organization = Organization.find_by_subscription_id(params['data']['object']['customer']).first
  organization.create_transaction(params['data']['object']) if organization
end

StripeEvent.subscribe 'charge.failed' do |event|
  params = event.data.object
  organization = Organization.find_by_subscription_id(params['data']['object']['customer']).first
  organization.create_transactions(params['data']['object']) if organization
end

StripeEvent.subscribe 'customer.subscription.updated' do |event|
  params = event.data.object
  organization = Organization.find_by_subscription_id(params['data']['object']['customer']).first
  organization.recurring_subscription(params['data']['object']) if organization
end