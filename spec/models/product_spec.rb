require 'spec_helper'

describe Product do
  it 'creates a new instance, given valid attributes' do
    Product.create!({
      title: 'Lorem Ipsum',
      description: 'Wibbles are fun!',
      image_url: 'lorem.jpg',
      price: 19.95
    })
  end

  context 'when there is no title' do
    it 'is not valid' do
      product = Product.new
      product.should validate_presence_of(:title)
    end
  end

  context 'when there is no description' do
    it 'is not valid' do
      product = Product.new
      product.should validate_presence_of(:description)
    end
  end

  context 'when there is no image URL' do
    it 'is not valid' do
      product = Product.new
      product.should validate_presence_of(:image_url)
    end
  end
end
