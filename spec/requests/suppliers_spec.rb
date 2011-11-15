require 'spec_helper'

describe 'Suppliers' do
  describe 'creation' do
    describe 'success' do
      it 'should make a supplier' do
        visit outlets_path

        click_link 'New supplier'

        fill_in :name, with: 'Emma Marshall'
      end
    end
  end
end