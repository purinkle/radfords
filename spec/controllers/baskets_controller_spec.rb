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
  end
end
