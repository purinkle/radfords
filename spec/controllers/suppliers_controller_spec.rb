require 'spec_helper'

describe SuppliersController do
  describe 'GET "new"' do
    it 'should be successful' do
      get :new

      response.should be_success
    end
  end

  describe 'POST "create"' do
    describe 'success' do
      let (:supplier) do
        {
          name: 'Shannon Sims',
          address: '8 Terrick Road, Eilean Darach IV23 0HE',
          telephone_number: '07820 955869'
        }
      end

      it 'should create a supplier' do
        lambda do
          post :create, supplier: supplier
        end.should change(Supplier, :count).by(1)
      end

      it 'should redirect to the supplier show page' do
        post :create, supplier: supplier

        response.should redirect_to(supplier_path(assigns(:supplier)))
      end
    end

    describe 'failure' do
      it 'should not create a supplier' do
        lambda do
          post :create, supplier: { name: '', address: '', telephone_number: '' }
        end.should_not change(Supplier, :count)
      end

      it 'should render the new page' do
        post :create, supplier: { name: '', address: '', telephone_number: '' }

        response.should render_template('new')
      end
    end
  end

  describe 'GET "show"' do
    let (:supplier) { Factory(:supplier) }

    it 'should be successful' do
      get :show, id: supplier

      response.should be_success
    end

    it 'should find the right event' do
      get :show, id: supplier

      assigns(:supplier).should == supplier
    end
  end

  describe 'GET "edit"' do
    it 'should be successful' do
      supplier = Factory(:supplier)

      get :edit, id: supplier

      response.should be_success
    end
  end
end