require 'spec_helper'

describe SuppliersController do
  render_views

  describe 'GET "new"' do
    before (:each) do
      test_sign_in( Factory(:user) )
    end

    it 'should be successful' do
      get 'new'

      response.should be_success
    end

    it 'should have the right title' do
      get 'new'

      response.should have_selector('title', :content => 'New Supplier')
    end

    it 'should have a name field' do
      get :new

      response.should have_selector("input[name='supplier[name]'][type='text']")
    end

    it 'should have a website field' do
      get :new

      response.should have_selector('input[name="supplier[website]"][type="text"]')
    end

    it 'should have a telephone number field' do
      get :new

      response.should have_selector('input[name="supplier[telephone_number]"][type="text"]')
    end
  end

  describe 'POST "create"' do
    describe 'failure' do
      before (:each) do
        test_sign_in( Factory(:user) )

        @attr = {
          :name => '',
          :address => '',
          :website => '',
          :telephone_number => ''
        }
      end

      it 'should not create a supplier' do
        lambda do
          post :create, :supplier => @attr
        end.should_not change( Supplier, :count )
      end

      it 'should have the right title' do
        post :create, :supplier => @attr

        response.should have_selector( 'title', :content => 'New Supplier' )
      end

      it 'should render the new page' do
        post :create, :supplier => @attr

        response.should render_template('new')
      end
    end

    describe 'success' do
      before (:each) do
        test_sign_in( Factory(:user) )

        @attr = {
          :name => 'Ethan Perry',
          :address => '75 Cambridge Road, Nolton SA62 1RZ',
          :website => 'http://insuranceintern.com/',
          :telephone_number => '07842 169160'
        }
      end

      it 'should create a supplier' do
        lambda do
          post :create, :supplier => @attr
        end.should change( Supplier, :count ).by(1)
      end

      it 'should redirect to the outlets page' do |variable|
        post :create, :supplier => @attr

        response.should redirect_to( outlets_path )
      end
    end
  end

  describe "GET 'edit'" do
    before (:each) do
      @supplier = Factory(:supplier)

      test_sign_in( Factory(:user) )
    end

    it "should be successful" do
      get :edit, :id => @supplier

      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @supplier

      response.should have_selector( :title, :content => "Edit Supplier" )
    end
  end

  describe "authentication of all pages" do
    before (:each) do
      @supplier = Factory(:supplier)

      @attr = {
        :name => 'Ethan Perry',
        :address => '75 Cambridge Road, Nolton SA62 1RZ',
        :website => 'http://insuranceintern.com/',
        :telephone_number => '07842 169160'
      }
    end

    describe "for non-signed-in users" do
      it "should deny access to 'create'" do
        post :create, :supplier => @attr

        response.should redirect_to(signin_path)
      end

      it "should deny access to 'new'" do
        get :new

        response.should redirect_to(signin_path)
      end

      it "should deny access to 'edit'" do
        get :edit, :id => @supplier

        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @supplier, :supplier => @attr

        response.should redirect_to(signin_path)
      end
    end
  end

  describe "PUT 'update'" do
    before (:each) do
      @supplier = Factory(:supplier)

      test_sign_in( Factory(:user) )
    end

    describe "failure" do
      before (:each) do
        @attr = {
          :name => '',
          :address => '',
          :website => '',
          :telephone_number => ''
        }
      end

      it "should render the 'edit' page" do
        put :update, :id => @supplier, :supplier => @attr

        response.should render_template("edit")
      end

      it "should have the right title" do
        put :update, :id => @supplier, :supplier => @attr

        response.should have_selector( :title, :content => "Edit Supplier" )
      end
    end

    describe "success" do
      before (:each) do
        @attr = {
          :name => 'Ethan Perry',
          :address => '75 Cambridge Road, Nolton SA62 1RZ',
          :website => 'http://insuranceintern.com/',
          :telephone_number => '07842 169160'
        }
      end

      it "should change the supplier's attributes" do
        put :update, :id => @supplier, :supplier => @attr

        @supplier.reload

        @supplier.name.should == @attr[:name]
        @supplier.address.should == @attr[:address]
        @supplier.website.should == @attr[:website]
        @supplier.telephone_number.should == @attr[:telephone_number]
      end

      it "should redirect to the outlets page" do
        put :update, :id => @supplier, :supplier => @attr

        response.should redirect_to( outlets_path )
      end
    end
  end
end
