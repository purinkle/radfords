require "rails_helper"

describe SessionsHelper do
  describe "#sign_out" do
    before do
      allow(cookies).to receive(:delete)
      allow(helper).to receive(:current_user=)
    end

    it "deletes the current user from the session" do
      helper.sign_out

      expect(cookies).to have_received(:delete).with(:remember_token)
      expect(helper).to have_received(:current_user=).with(nil)
    end
  end
end
