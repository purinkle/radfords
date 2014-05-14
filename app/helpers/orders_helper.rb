module OrdersHelper
  def show_order_button(viewed)
    { true => 'btn-success' }.fetch(viewed, 'btn-warning')
  end
end
