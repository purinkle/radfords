# encoding : utf-8

MoneyRails.configure do |config|
  config.default_currency = :gbp

  # The column is price_pennies, not the money-rails default of _cents.
  config.amount_column = { postfix: "_pennies" }

  # The money gem defaults to the legacy locale backend, which warns on every
  # lookup that it is going away. Legacy reads number.currency.format from
  # I18n and falls back to the currency itself. This app sets no such keys, so
  # :currency is what legacy already resolves to here, and £1,234.56 formats
  # the same either way.
  config.locale_backend = :currency

  # This is the money gem's default today. It warns that it will switch to
  # ROUND_HALF_UP, so hold the current value and leave that change to whoever
  # makes it on purpose.
  config.rounding_mode = BigDecimal::ROUND_HALF_EVEN
end
