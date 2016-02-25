VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "support", "cassettes")
  c.hook_into :webmock
end
