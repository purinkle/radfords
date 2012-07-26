# == Schema Information
#
# Table name: suppliers
#
#  id               :integer         not null, primary key
#  address          :string(255)
#  name             :string(255)
#  telephone_number :string(255)
#  website          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Supplier do
  before(:each) do
    @attr = { address: '98 St Denys Road, Portslade BN41 4DS', name: 'Paige Pritchard', telephone_number: '070 8158 4942', website: 'http://funerallife.com/' }
    Supplier.any_instance.stub :geocode
  end

  it 'should create a new instance given valid attributes' do
    Supplier.create!(@attr)
  end

  it 'should require an address' do
    no_address_supplier = Supplier.create(@attr.merge(address: ''))
    no_address_supplier.should_not be_valid
  end

  it 'should require a name' do
    no_name_supplier = Supplier.create(@attr.merge(name: ''))
    no_name_supplier.should_not be_valid
  end

  it 'should require a telephone number' do
    no_telephone_number_supplier = Supplier.create(@attr.merge(telephone_number: ''))
    no_telephone_number_supplier.should_not be_valid
  end
end
