require 'spec_helper'

describe Basket do
  it 'has many line items' do
    should have_many(:line_items).dependent(:destroy)
  end
end
