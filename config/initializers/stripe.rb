if Rails.env.production?
  Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
    secret_key: ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    publishable_key: 'pk_test_2zoS8Jrxas0rcZLuYNpGChSM',
    secret_key: 'sk_test_yV906QWxUiHfE2X7Z3wrq8C4'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
