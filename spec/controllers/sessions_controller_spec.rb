require "rails_helper"

describe SessionsController do
  describe 'GET "new"' do
    it 'should be successful' do
      get :new

      expect(response).to be_success
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

        expect(response).to render_template("new")
      end

      it 'should have the right title' do
        post :create, :session => @attr
        expect(assigns(:title)).to eql("Sign In")
      end

      it "sets the alert flash" do
        allow(User).to receive(:authenticate)

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

        expect(controller.current_user).to eq(@user)
        expect(controller).to be_signed_in
      end

      it 'should redirect to the new event page' do
        post :create, :session => @attr

        expect(response).to redirect_to(events_path)
      end
    end
  end

  describe "DELETE 'destroy'" do
    before do
      allow(controller).to receive(:find_basket)
      allow(controller).to receive(:sign_out)
    end

    it "redirects to the home page" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end

    it 'sets the success flash' do
      delete :destroy
      expect(flash[:success]).to eq("You successfully signed out.")
    end
  end
end
