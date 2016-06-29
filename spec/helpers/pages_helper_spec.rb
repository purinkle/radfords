require "rails_helper"

describe PagesHelper do
  describe '#product_button' do
    subject { helper.product_button(product) }

    let(:partial) { double('partial') }
    let(:product) { double('product') }

    before do
      allow(helper).to receive(:render).with(
        partial: "shared/product_button",
        locals: { product: product }
      ).once.and_return(partial)
    end

    it "renders the partial" do
      expect(subject).to be(partial)
    end
  end
end
