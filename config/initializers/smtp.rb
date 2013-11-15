if Rails.env.staging? || Rails.env.production?
  SMTP_SETTINGS = {
    address: ENV['SMTP_ADDRESS'],
    authentication: :plain,
    domain: ENV['SMTP_DOMAIN'],
    password: ENV['SMTP_PASSWORD'],
    port: 587,
    user_name: ENV['SMTP_USERNAME']
  }
end
