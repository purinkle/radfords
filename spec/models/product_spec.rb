require 'spec_helper'

describe Product do
  let(:product) { described_class.new }

  describe '#ensure_not_referenced_by_any_line_item' do
    subject { product.send(:ensure_not_referenced_by_any_line_item) }

    let(:line_items) { [] }

    before do
      product.stub(:line_items).once.with(no_args).and_return(line_items)
    end

    it 'returns true' do
      expect(subject).to be_true
    end

    context 'when the product belongs to a line item' do
      let(:line_items) { [double('line item')] }

      it 'returns false' do
        expect(subject).to be_false
      end
    end
  end
end
