require 'spec_helper'

describe SessionsController do
  describe 'GET "new"' do
    it 'should be successful' do
      get :new

      response.should be_success
    end

    it 'should have the right title' do
      get :new
      expect(assigns(:title)).to eql("Sign In")
    end
  end

  describe 'POST "create"' do
    describe 'invalid signin' do
      before (:each) do
        @attr = { :email => 'email@example.com', :password => 'invalid' }
      end

      it 'should re-render the new page' do
        post :create, :session => @attr

        response.should render_template('new')
      end

      it 'should have the right title' do
        post :create, :session => @attr
        expect(assigns(:title)).to eql("Sign In")
      end

      it "sets the alert flash" do
        User.stub(authenticate: nil)

        post :create, session: {}

        expect(flash[:alert]).to eql "Invalid email or password."
      end
    end

    describe 'with valid email and password' do
      before (:each) do
        @user = FactoryGirl.create(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it 'should sign the user in' do
        post :create, :session => @attr

        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it 'should redirect to the new event page' do
        post :create, :session => @attr

        response.should redirect_to events_path
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should sign a user out" do
      test_sign_in( FactoryGirl.create(:user) )

      delete :destroy

      controller.should_not be_signed_in

      response.should redirect_to(root_path)
    end

    it 'sets the success flash' do
      delete :destroy
      flash[:success].should == 'You successfully signed out.'
    end
  end
end
