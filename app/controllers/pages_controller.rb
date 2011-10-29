class PagesController < ApplicationController
  def home
    @title = "Home"
    @event = Event.find(:first, conditions: [ "takes_place_on > ?", Time.now ],
                                order: "takes_place_on ASC" )
  end

  def products
    @title = "Products"
  end

  def outlets
    @title = "Outlets"
  end

  def contact
    @title = "Contact"
  end

end
