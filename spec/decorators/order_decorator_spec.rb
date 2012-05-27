require 'spec_helper'

describe OrderDecorator do
  context '#line_items' do
    let(:decorator) { OrderDecorator.new(stub) }
    let(:line_items) { stub }

    before(:each) do
      decorator.stub(model: stub(line_items: stub))
      LineItemDecorator.stub(decorate: line_items)
    end

    it "gets the decorator's model" do
      decorator.should_receive(:model).with(no_args)
      decorator.line_items
    end

    it "gets the model's line items" do
      decorator.model.should_receive(:line_items).with(no_args)
      decorator.line_items
    end

    it "decorates the line items" do
      LineItemDecorator.should_receive(:decorate).
        with(decorator.model.line_items)

      decorator.line_items
    end

    it "returns the decorated line items" do
      decorator.line_items.should == line_items
    end
  end
end