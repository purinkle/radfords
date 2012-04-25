module Baskets
  include Spinach::DSL

  When 'I click an "Add to Cart" button' do
    click_button('Add to Cart')
  end

  When 'I click the "Checkout" button' do
    click_button('Checkout')
  end
end
