module Paths
  include Spinach::DSL

  When 'I visit the new product page' do
    visit new_product_path
  end
end
