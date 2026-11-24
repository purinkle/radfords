require "rails_helper"

describe PagesHelper do
  describe "#product_button" do
    subject(:button) { helper.product_button(product) }

    let(:partial) { "<form></form>".html_safe }
    let(:product) { instance_double(Product) }

    before do
      allow(helper).to receive(:render).with(
        partial: "shared/product_button",
        locals: { product: product }
      ).once.and_return(partial)
    end

    it "renders the partial" do
      expect(button).to be(partial)
    end
  end
end
