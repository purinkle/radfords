VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "support", "cassettes")
  c.hook_into :webmock

  # Capybara's server handshake and every page request a browser makes run
  # over localhost. They are not traffic worth recording.
  c.ignore_localhost = true
end
