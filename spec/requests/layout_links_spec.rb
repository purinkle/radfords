require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  
  it "should have a Products page at '/products'" do
    get '/products'
    response.should have_selector('title', :content => "Products")
  end
  
  it "should have an Outlets page at '/outlets'" do
    get '/outlets'
    response.should have_selector('title', :content => "Outlets")
  end
  
  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end
end
