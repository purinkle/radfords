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
        "success" => "qux"
      }
    end

    let(:flash) { instance_double(ActionDispatch::Flash::FlashHash, to_hash: flashes) }
    let(:user_facing_keys) { %w[alert error notice success] }

    before do
      allow(helper).to receive(:flash).and_return(flash)
    end

    it "removes unwanted flashes", :aggregate_failures do
      expect(keys).to eql(user_facing_keys)
      expect(keys).not_to include("quux")
    end
  end
end
