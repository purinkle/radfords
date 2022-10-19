if Rails.env.development? || Rails.env.test?
  require "factory_girl"

  namespace :dev do
    desc "Sample data for local development environment"
    task prime: "db:setup" do
      include FactoryGirl::Syntax::Methods

      create(:user, email: "admin@example.com", password: "password")
      create(:product, price: Money.new(5_00))
    end
  end
end
