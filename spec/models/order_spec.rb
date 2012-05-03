require 'spec_helper'

describe Order do
  let(:order) { Order.new }

  it 'has a name' do
    order.should respond_to(:name)
  end

  it 'has an address' do
    order.should respond_to(:address)
  end

  it 'has an email' do
    order.should respond_to(:email)
  end

  context 'when there is no name' do
    it 'is not valid' do
      order.should validate_presence_of(:name)
    end
  end

  context '#add_line_items_from_basket' do
    let(:basket) { stub(line_items: line_items) }
    let(:line_item_1) { stub(:basket_id= => nil) }
    let(:line_item_2) { stub(:basket_id= => nil) }
    let(:line_items) { [line_item_1, line_item_2] }

    before(:each) do
      order.stub(line_items: stub(:<< => nil))
    end

    it 'gets all of the items in the basket' do
      basket.should_receive(:line_items).with(no_args)
      order.add_line_items_from_basket(basket)
    end

    it 'sets the basket identifier for each item to nil' do
      line_item_1.should_receive(:basket_id=).with(nil)
      line_item_2.should_receive(:basket_id=).with(nil)
      order.add_line_items_from_basket(basket)
    end

    it 'adds the items to the order' do
      order.line_items.should_receive(:<<).with(line_item_1)
      order.line_items.should_receive(:<<).with(line_item_2)
      order.add_line_items_from_basket(basket)
    end
  end
end
