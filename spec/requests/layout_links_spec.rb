require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have an Outlets page at '/outlets'" do
    get '/outlets'
    response.should have_selector('title', :content => "Outlets")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Where to buy"
    response.should have_selector('title', :content => "Outlets")
    click_link "Contact us"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
  end
end
