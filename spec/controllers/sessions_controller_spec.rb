require "rails_helper"

describe SessionsController do
  describe 'GET "new"' do
    it "is successful" do
      get :new

      expect(response).to be_successful
    end
  end

  describe 'POST "create"' do
    describe "invalid signin" do
      let(:attr) { { email: "email@example.com", password: "invalid" } }

      it "sets the alert flash" do
        allow(User).to receive(:authenticate)

        post :create, params: { session: attr }

        expect(flash[:alert]).to eql "Invalid email or password."
      end
    end

    describe "with valid email and password" do
      let(:user) { create(:user) }
      let(:attr) { { email: user.email, password: user.password } }

      it "signs the user in", :aggregate_failures do
        post :create, params: { session: attr }

        expect(controller.current_user).to eq(user)
        expect(controller).to be_signed_in
      end

      it "redirects to the new event page" do
        post :create, params: { session: attr }

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

    it "sets the success flash" do
      delete :destroy
      expect(flash[:success]).to eq("You successfully signed out.")
    end
  end
end
