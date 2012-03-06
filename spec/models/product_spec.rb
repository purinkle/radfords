require 'spec_helper'

describe Product do
  let(:attr) do
    {
      description: 'Wibbles are fun!',
      image_url: 'lorem.jpg',
      price: 19.95,
      title: 'Lorem Ipsum',
    }
  end

  it 'creates a new instance, given valid attributes' do
    Product.create!(attr)
  end

  context 'when there is no title' do
    it 'is not valid' do
      product = Product.new(attr)
      product.should validate_presence_of(:title)
    end
  end

  context 'when there is no description' do
    it 'is not valid' do
      product = Product.new(attr)
      product.should validate_presence_of(:description)
    end
  end

  context 'when there is no image URL' do
    it 'is not valid' do
      product = Product.new(attr)
      product.should validate_presence_of(:image_url)
    end
  end

  context 'when the price is not a number' do
    it 'is not valid' do
      product = Product.new(attr.merge(price: 'foo'))
      product.valid?.should be_false
    end
  end

  context 'when the price is less than 0.01' do
    it 'is not valid' do
      product = Product.new(attr.merge(price: 0))
      product.valid?.should be_false
    end
  end

  context 'when the title is not unique' do
    it 'is not valid' do
      Product.create!(attr)
      product = Product.new(attr)
      product.valid?.should be_false
    end
  end

  context 'when there is no title' do
    it 'is not valid' do
      product = Product.new
      product.should validate_presence_of(:title)
    end
  end
end
