module Paths
  include Spinach::DSL

  When 'I visit the new product page' do
    visit new_product_path
  end

  When 'I am looking at the products list' do
    visit products_path
  end

  When 'I visit the edit product page' do
    visit edit_product_path(1)
  end

  When 'I visit the products page' do
    visit products_path
  end

  When 'I visit a product page' do
    visit product_path(1)
  end

  When 'I visit an invalid basket' do
    visit basket_path('wibble')
  end

  When 'I visit the home page' do
    visit root_path
  end

  When 'I visit the order index' do
    visit orders_path
  end

  When 'I visit the order\'s page' do
    visit order_path(1)
  end

  When 'I am on the new supplier page' do
    visit new_supplier_path
  end

  When 'I am on the suppliers page' do
    visit outlets_path
  end

  When 'I am editing a supplier' do
    visit edit_supplier_path 1
  end

  When 'I am creating a supplier' do
    visit new_supplier_path
  end

  Given 'I am deleting a supplier' do
    visit delete_supplier_path 1
  end

  When 'I am deleting an event' do
    visit delete_event_path 1
  end

  When 'I am deleting an invalid event' do
    visit delete_event_path 'foo'
  end

  When 'I am looking at all of the events' do
    visit events_path
  end
end
