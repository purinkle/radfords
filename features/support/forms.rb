module Forms
  module Product
    include Spinach::DSL

    When 'I create a valid product' do
      fill_in 'product_title', with: 'Lorem Ipsum'
      fill_in 'product_description', with: 'Wibbles are fun!'
      fill_in 'product_image_url', with: 'lorem.jpg'
      fill_in 'product_price', with: 19.95

      click_button 'Create Product'
    end

    When 'I delete a product' do
      click_button 'Delete'
    end
  end
end
