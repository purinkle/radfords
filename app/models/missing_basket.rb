# A null object, so it has no state for line_items to depend on.
# :reek:UtilityFunction
class MissingBasket
  def line_items
    LineItem.none
  end
end
