module Orders
  include Spinach::DSL

  When 'I create an invalid order' do
    fill_in 'order_name', with: ''
    fill_in 'order_address', with: ''
    fill_in 'order_email', with: ''
    click_button 'Place Order'
  end
end
