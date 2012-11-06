require 'spec_helper'

describe ProductHelper do
  describe '#product_list' do
    subject { helper.product_list(products) }

    let(:products) { [double(:product)] }

    it 'returns "product_list"' do
      expect(subject).to eql('product_list')
    end

    context 'when there are no products' do
      let(:products) { [] }

      it 'returns "no_products"' do
        expect(subject).to eql('no_products')
      end
    end
  end
end
