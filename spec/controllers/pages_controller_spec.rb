require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'products'" do
    it "should be successful" do
      get 'products'
      response.should be_success
    end
  end
  
  describe "GET 'outlets'" do
    it "should be successful" do
      get 'outlets'
      response.should be_success
    end
  end

end
