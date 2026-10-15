class FakeStripe < Sinatra::Base
  cattr_accessor :charges, :customer

  post "/v1/charges" do
    charges << params
    {}.to_json
  end

  post "/v1/customers" do
    customer.to_json
  end

  def self.clear
    self.charges = []
    self.customer = {}
  end
end

RSpec.configure do |config|
  config.before :each do
    stub_request(:any, /api\.stripe\.com/).to_rack FakeStripe
    FakeStripe.clear
  end
end
