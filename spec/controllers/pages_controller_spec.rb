require 'spec_helper'

describe PagesController do
  render_views

  before (:each) do
    @base_title = "Radfords of Somerford"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                    :content => "Home | " + @base_title)
    end

    it "should display the next event" do
      event1 = Factory( :event, name: "Melton Mowbray Farmers' Market",
                                takes_place_on: 1.week.ago,
                                location: "Cattle Market, Scarlford Road" )
      event2 = Factory( :event, name: "Huntingdon Farmer's Market",
                                takes_place_on: 1.week.from_now,
                                location: "Market Square" )
      event3 = Factory( :event, name: "Otley Farmer's Market",
                                takes_place_on: 1.day.from_now,
                                location: "Market Square")

      get :home

      response.should have_selector("span.title",
                                    :content => event3.name)
    end
  end

  describe "GET 'products'" do
    it "should be successful" do
      get 'products'
      response.should be_success
    end

    it "should have the right title" do
      get 'products'
      response.should have_selector("title",
                                    :content => "Products | " + @base_title)
    end
  end

  describe "GET 'outlets'" do
    it "should be successful" do
      get 'outlets'
      response.should be_success
    end

    it "should have the right title" do
      get 'outlets'
      response.should have_selector("title",
                                    :content => "Outlets | " + @base_title)
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => "Contact | " + @base_title)
    end
  end

end
