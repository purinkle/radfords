# A null object, so it has no state for line_items to depend on.
# :reek:UtilityFunction
class EmptyBasket
  def line_items
    LineItem.none
  end

  def to_partial_path
    "empty_basket"
  end
end
