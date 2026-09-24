const { environment } = require('@rails/webpacker')

// The Stripe stub hands out fake tokens, so only the test environment may
// build it. The suite and CI both reach webpack with RAILS_ENV set to test.
if (process.env.RAILS_ENV !== 'test') {
  environment.entry.delete('stripe_stub')
}

module.exports = environment
