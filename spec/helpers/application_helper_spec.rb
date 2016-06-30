require "rails_helper"

describe ApplicationHelper do
  describe '#humanize_price' do
    subject { helper.humanize_price(price) }

    let(:formatted_price) { '£10.95' }
    let(:price) { Money.new(1095) }

    before do
      allow(helper).to receive(:humanized_money_with_symbol).
        with(price, no_cents_if_whole: false).and_return(formatted_price)
    end

    it 'returns the formatted price with symbol' do
      expect(subject).to be(formatted_price)
    end
  end

  describe "#navbar" do
    it "renders the navbar partial" do
      allow(helper).to receive(:signed_in?).and_return(true)

      expect(helper).to receive :render

      helper.navbar
    end

    context "when the user is not signed in" do
      it "returns nil" do
        allow(helper).to receive(:signed_in?).and_return(false)

        navbar = helper.navbar

        expect(navbar).to be_nil
      end
    end
  end

  describe "#nav_class" do
    it "returns 'active'" do
      allow(controller).to receive(:controller_name).and_return("foo")

      nav_class = helper.nav_class("foo")

      expect(nav_class).to eql "active"
    end

    context "when the name doesn't match the current controller" do
      it "returns nil" do
        allow(controller).to receive(:controller_name).and_return("foo")

        nav_class = helper.nav_class("bar")

        expect(nav_class).to be_nil
      end
    end
  end
end
