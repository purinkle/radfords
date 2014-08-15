require 'spec_helper'

describe PagesHelper do
  describe '#product_button' do
    subject { helper.product_button(product) }

    let(:partial) { double('partial') }
    let(:product) { double('product') }
    let(:signed_in?) { false }

    before do
      allow(helper).to receive(:signed_in?).with(no_args).and_return(signed_in?)
      allow(helper).to receive(:render).with(
        partial: 'product_button',
        locals: { product: product }
      ).once.and_return(partial)
    end

    it 'returns nil' do
      expect(subject).to be_nil
    end

    context 'when the user is signed in' do
      let(:signed_in?) { true }

      it 'renders the partial' do
        expect(subject).to be(partial)
      end
    end
  end

  describe "#render_basket" do
    subject { helper.render_basket(basket) }

    let(:basket) { double("Basket", line_items: line_items) }
    let(:line_item) { double("LineItem") }
    let(:line_items) { [line_item] }
    let(:partial) { double("partial") }

    before do
      allow(helper).to receive(:render).with(basket).and_return(partial)
    end

    it "renders the basket" do
      expect(subject).to be(partial)
    end

    context "when the basket has no line items" do
      let(:line_items) { [] }

      it "returns nil" do
        expect(subject).to be_nil
      end
    end
  end
end
