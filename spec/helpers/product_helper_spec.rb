require "rails_helper"

describe ProductHelper do
  describe "#product_list" do
    subject(:list_class) { helper.product_list(products) }

    let(:products) { [instance_double(Product)] }

    it 'returns "product_list"' do
      expect(list_class).to eql("product_list")
    end

    context "when there are no products" do
      let(:products) { [] }

      it 'returns "no_products"' do
        expect(list_class).to eql("no_products")
      end
    end
  end
end
