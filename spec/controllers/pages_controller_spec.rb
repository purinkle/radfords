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
