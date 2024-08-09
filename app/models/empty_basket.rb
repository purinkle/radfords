class EmptyBasket
  def line_items
    LineItem.none
  end

  def to_partial_path
    "empty_basket"
  end
end
