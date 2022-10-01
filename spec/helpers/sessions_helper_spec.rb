require "rails_helper"

describe SessionsHelper do
  describe "#sign_out" do
    it "deletes the current user from the session" do
      helper.current_user = build_stubbed(:user)
      helper.cookies[:remember_token] = "TEST_REMEMBER_TOKEN"

      helper.sign_out

      expect(helper.cookies[:remember_token]).to be_nil
      expect(helper.current_user).to be_nil
    end
  end
end
