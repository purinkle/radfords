class PagesController < ApplicationController
  def home
    @title = "Home"
    @events = Event.find(:all, conditions: [ "takes_place_on > ?", Time.now ],
                               limit: 3 )
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
