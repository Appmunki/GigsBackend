Rails.configuration.stripe = {
  :publishable_key => 'pk_test_GSnTcklRvQE1kIw8EJ5Kppe6',#ENV['PUBLISHABLE_KEY'],
  :secret_key      => 'sk_test_khwQNFLXJ3HAl2jsxoGduL3B'#ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]