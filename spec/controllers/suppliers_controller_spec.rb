require 'spec_helper'

describe SuppliersController do
  render_views

  describe 'GET "new"' do
    before (:each) do
      test_sign_in( FactoryGirl.create(:user) )
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
    before(:each) do
      Supplier.any_instance.stub :geocode
    end

    describe 'failure' do
      before (:each) do
        test_sign_in( FactoryGirl.create(:user) )

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
        test_sign_in( FactoryGirl.create(:user) )

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
      Supplier.any_instance.stub :geocode
      @supplier = FactoryGirl.create(:supplier)

      test_sign_in( FactoryGirl.create(:user) )
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
      Supplier.any_instance.stub :geocode
      @supplier = FactoryGirl.create(:supplier)

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
      Supplier.any_instance.stub :geocode
      @supplier = FactoryGirl.create(:supplier)

      test_sign_in( FactoryGirl.create(:user) )
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

  describe 'DELETE "destroy"' do
    let(:id) { '1' }

    context 'when signed in' do
      let(:supplier) { stub.as_null_object }

      before(:each) do
        controller.stub(signed_in?: true)
        Supplier.stub(find: supplier)
      end

      it 'finds the supplier' do
        Supplier.should_receive(:find).with(id)
        delete :destroy, id: id
      end

      it 'stores the supplier' do
        delete :destroy, id: id
        assigns(:supplier).should == supplier
      end

      it 'destroys the supplier' do
        supplier.should_receive(:destroy)
        delete :destroy, id: id
      end

      it 'sets the success flash' do
        delete :destroy, id: id
        flash[:success].should == 'You successfully deleted the product.'
      end

      it 'redirects to the outlets page' do
        delete :destroy, id: id
        response.should redirect_to(outlets_path)
      end
    end

    context 'when not signed in' do
      it 'sets the error flash' do
        post :destroy, id: id
        flash[:error].should == 'Please sign in to access this page.'
      end

      it 'redirects to the sign in page' do
        post :destroy, id: id
        response.should redirect_to(signin_path)
      end
    end
  end
end
