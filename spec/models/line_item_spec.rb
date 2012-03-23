require 'spec_helper'

describe LineItem do
  it 'belongs to a basket' do
    should belong_to(:basket)
  end

  it 'belongs to a product' do
    should belong_to(:product)
  end
end
