require 'spec_helper'

describe BasketsController do
  context '#show' do
    let(:id) { stub }

    it 'is successful' do
      get :show, id: id
      response.should be_success
    end

    it 'sets the title' do
      get :show, id: id
      assigns(:title).should == 'Basket'
    end
  end
end
