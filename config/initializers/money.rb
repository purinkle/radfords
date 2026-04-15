# encoding : utf-8

MoneyRails.configure do |config|
  config.default_currency = :gbp
  config.amount_column = { postfix: '_pennies' }
end
