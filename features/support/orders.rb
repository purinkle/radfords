module Orders
  include Spinach::DSL

  When 'I create an invalid order' do
    fill_in 'order_name', with: ''
    fill_in 'order_address', with: ''
    fill_in 'order_email', with: ''
    click_button 'Place Order'
  end

  When 'I create a valid order' do
    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main St'
    fill_in 'order_email', with: 'customer@pragprog.com'
    click_button 'Place Order'
  end

  And 'several orders have been created' do
    FactoryGirl.create(
      :order,
      {
        name: 'Randall Waters',
        address: '20383 Sawayn Inlet',
        email: 'waters.randall@kerluke.info'
      }
    )

    FactoryGirl.create(
      :order,
      {
        name: 'Retta O\'Keefe',
        address: '87920 Fay Fields',
        email: 'o_keefe_retta@langkshlerin.us'
      }
    )
  end

  When 'an order has been created' do
    order = FactoryGirl.create(
      :order,
      {
        name: 'Randall Waters',
        address: '20383 Sawayn Inlet',
        email: 'waters.randall@kerluke.info'
      }
    )

    FactoryGirl.create(
      :line_item,
      {
        quantity: 2,
        product: FactoryGirl.create(
          :product,
          {
            title: 'Blueberry and Apple Preserve',
            description: 'Blueberries and apples blended together with sugar and
              a dash of lemon juice to create a simple flavour which is not too
              sweet.'
          }
        ),
        order: order
      }
    )

    FactoryGirl.create(
      :line_item,
      {
        quantity: 3,
        product: FactoryGirl.create(
          :product,
          {
            title: 'Apricot and Ginger Preserve',
            description: 'Sweet apricots infused with ginger, with sugar and a
              dash of lemon.'
          }
        ),
        order: order
      }
    )
  end
end
