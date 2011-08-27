require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                    :content => "Home | Radfords of Somerford")
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
                                 :content => "Products | Radfords of Somerford")
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
                                  :content => "Outlets | Radfords of Somerford")
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
                                  :content => "Contact | Radfords of Somerford")
    end
  end

end
