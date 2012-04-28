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
end
