require "rails_helper"

describe Product do
  let(:product) { build(:product) }

  describe "#to_s" do
    it "returns the title" do
      expect(product.to_s).to eql(product.title)
    end
  end

  describe '#ensure_not_referenced_by_any_line_item' do
    subject { product.send(:ensure_not_referenced_by_any_line_item) }

    let(:line_items) { [] }

    before do
      allow(product).to receive(:line_items).once.with(no_args).
        and_return(line_items)
    end

    it 'returns true' do
      expect(subject).to be true
    end

    context 'when the product belongs to a line item' do
      let(:line_items) { [double('line item')] }

      it 'returns false' do
        expect(subject).to be false
      end
    end
  end
end
