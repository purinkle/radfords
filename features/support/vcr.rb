VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('features', 'support', 'vcr')
  c.hook_into :webmock
end

class StubSocket
  attr_accessor :continue_timeout
end
