Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_51OyXCC068MYgAdXZPMOu2TasTfKXdSOWdwqvpkMTGRhoCNCRJ1UYgFO8rRHJOV7lLSfH1QMlXKBeLmKXQWLMRYCU00y5F4lcAR'],
  secret_key:      ENV['sk_test_51OyXCC068MYgAdXZreDD9gkwhlZfl8jWn5wXsJAfaip5QJTXlcdcJhvNsUwnzHSeszKJXz0XiqUXjC6lo3bqXMaH00Byl9wBna']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
