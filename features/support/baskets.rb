module Baskets
  include Spinach::DSL

  When 'I click an "Add to Cart" button' do
    click_button('Add to Cart')
  end
end
