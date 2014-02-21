require 'spec_helper'

describe PagesHelper do
  describe '#product_button' do
    subject { helper.product_button(product) }

    let(:partial) { double('partial') }
    let(:product) { double('product') }
    let(:signed_in?) { false }

    before do
      helper.stub(:signed_in?).with(no_args).once.and_return(signed_in?)
      helper.stub(:render).with(
        partial: 'product_button',
        locals: {product: product}
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
end
