class CombineItemsInBasket < ActiveRecord::Migration
  def self.up
    Basket.all.each do |basket|
      sums = basket.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1 
          basket.line_items.where(product_id: product_id).delete_all
          basket.line_items.create(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  def self.down
    LineItem.where('quantity > 1').each do |line_item|
      line_item.quantity.times do
        LineItem.create(
          basket_id: line_item.basket_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end

      line_item.destroy
    end
  end
end
