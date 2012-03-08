module Paths
  include Spinach::DSL

  When 'I visit the new product page' do
    visit new_product_path
  end

  When 'I visit the edit product page' do
    visit edit_product_path(1)
  end
end
