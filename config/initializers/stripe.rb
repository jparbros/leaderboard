Stripe.api_key = "sk_test_mZww9eF34Na4z1kZz2E6Y9Of"

StripeEvent.subscribe 'charge.succeeded' do |event|
  puts event.data.object
end