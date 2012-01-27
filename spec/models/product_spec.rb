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
end
