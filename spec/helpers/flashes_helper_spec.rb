require "rails_helper"

describe FlashesHelper do
  describe "#user_facing_flashes" do
    subject(:keys) { helper.user_facing_flashes.keys }

    let(:flashes) do
      {
        "alert" => "foo",
        "error" => "bar",
        "notice" => "baz",
        "quux" => "corge",
        "success" => "qux",
      }
    end

    let(:flash) { double("ActionDispatch::Flash", to_hash: flashes) }
    let(:user_facing_keys) { %w(alert error notice success) }

    before do
      allow(helper).to receive(:flash).and_return(flash)
    end

    it "removes unwanted flashes" do
      expect(keys).to eql(user_facing_keys)
      expect(keys).to_not include("quux")
    end
  end
end
