require 'spec_helper'

describe Product do
  describe '#ensure_not_referenced_by_any_line_item' do
    it 'returns true' do
      product = Product.new
      product.stub(:line_items).once.with(no_args) { [] }
      expect(product.send(:ensure_not_referenced_by_any_line_item)).to be_true
    end

    it 'returns false' do
      product = Product.new
      product.stub(:line_items).once.with(no_args) { [stub] }
      expect(product.send(:ensure_not_referenced_by_any_line_item)).to be_false
    end
  end
end
