require 'spec_helper'

describe BasketsController do
  context '#show' do
    let(:basket) { stub }
    let(:id) { stub }

    before(:each) do
      Basket.stub(find: basket)
    end

    it 'is successful' do
      get :show, id: id
      response.should be_success
    end

    it 'finds the basket' do
      Basket.should_receive(:find).with(id)
      get :show, id: id
    end

    it 'stores the basket' do
      get :show, id: id
      assigns(:basket).should == basket
    end

    it 'sets the title' do
      get :show, id: id
      assigns(:title).should == 'Basket'
    end

    context 'when a basket cannot be found' do
      let(:logger) {stub(error: nil)}

      before(:each) do
        Basket.stub(:find).and_raise(ActiveRecord::RecordNotFound)
        controller.stub(logger: logger)
      end

      it 'logs the error' do
        controller.logger.should_receive(:error).with("Attempt to access invalid basket #{id}")
        get :show, id: id
      end

      it 'sets the error flash' do
        get :show, id: id
        flash[:error].should == 'Invalid basket.'
      end

      it 'redirects to the Products page' do
        get :show, id: id
        should redirect_to(products_path)
      end
    end
  end

  context '#destroy' do
    let(:current_basket) { stub(destroy: nil) }
    let(:id) { stub }

    before(:each) do
      controller.stub(current_basket: current_basket)
    end

    it 'gets the current basket' do
      controller.should_receive(:current_basket)
      delete :destroy, id: id
    end

    it 'stores the current basket' do
      delete :destroy, id: id
      assigns(:basket).should == current_basket
    end

    it 'destroys the current basket' do
      current_basket.should_receive(:destroy)
      delete :destroy, id: id
    end

    it 'resets the basket identifier in the session' do
      delete :destroy, id: id
      session[:basket_id].should == nil
    end

    it 'sets the info flash' do
      delete :destroy, id: id
      flash[:info].should == 'Your basket is currently empty.'
    end

    it 'redirects to the Products page' do
      delete :destroy, id: id
      should redirect_to(products_path)
    end
  end
end
