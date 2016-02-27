require "rails_helper"

describe SessionsHelper do
  describe "#sign_out" do
    let(:cookies) { double("ActionDispatch::Cookies::CookieJar", delete: nil) }

    before do
      allow(helper).to receive_messages(
        :cookies => cookies,
        :current_user= => nil,
      )
    end

    it "deletes the current user from the session" do
      helper.sign_out

      expect(cookies).to have_received(:delete).with(:remember_token)
      expect(helper).to have_received(:current_user=).with(nil)
    end
  end
end
