require 'spec_helper'

describe LineItemDecorator do
  context "#product" do
    let(:line_item_decorator) { LineItemDecorator.new(stub) }

    before(:each) do
      line_item_decorator.stub(model: stub(product: stub))
      ProductDecorator.stub(decorate: stub)
    end

    it "gets the decorator's model" do
      line_item_decorator.should_receive(:model).with(no_args)
      line_item_decorator.product
    end

    it "gets the model's product" do
      line_item_decorator.model.should_receive(:product).with(no_args)
      line_item_decorator.product
    end

    it "decorates the product" do
      ProductDecorator.should_receive(:decorate).
        with(line_item_decorator.model.product)

      line_item_decorator.product
    end

    it "returns the decorated product" do
      line_item_decorator.product.should == ProductDecorator.decorate
    end
  end
end