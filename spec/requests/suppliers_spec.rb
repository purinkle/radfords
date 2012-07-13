require 'spec_helper'

describe 'Suppliers' do
  describe 'creation' do
    before (:each) do
      user = FactoryGirl.create(:user)

      visit signin_path

      fill_in :email,    :with => user.email
      fill_in :password, :with => user.password

      click_button
    end

    describe 'failure' do
      it 'should not make a supplier' do
        lambda do
          visit new_supplier_path

          fill_in 'Name', :with => ''
          fill_in 'Address', :with => ''
          fill_in 'Website', :with => ''
          fill_in 'Telephone number', :with => ''

          click_button

          response.should render_template('suppliers/new')
          response.should have_selector('.alert-block')
        end.should_not change( Supplier, :count )
      end
    end

    describe 'success' do
      it 'should make a supplier' do
        lambda do
          visit new_supplier_path

          fill_in 'Name', :with => 'Ethan Perry'
          fill_in 'Address', :with => '75 Cambridge Road, Nolton SA62 1RZ'
          fill_in 'Website', :with => 'http://insuranceintern.com/'
          fill_in 'Telephone number', :with => '07842 169160'

          click_button

          response.should render_template('pages/outlets')
        end.should change( Supplier, :count ).by(1)
      end
    end
  end

  describe 'when not signed in' do
    it 'should not have a creation link' do
      visit outlets_path

      response.should_not have_selector('a', href: new_supplier_path,
                                             content: 'New supplier')
    end
  end

  describe 'when signed in' do
    before (:each) do
      user = FactoryGirl.create(:user)

      visit signin_path

      fill_in :email,    :with => user.email
      fill_in :password, :with => user.password

      click_button
    end

    it 'should have a creation link' do
      visit outlets_path

      response.should have_selector('a', href: new_supplier_path,
                                         content: 'New')
    end
  end
end