require 'spec_helper'

describe FulfilmentsController do
  describe 'POST "create"' do
    let(:order) { double(Order) }
    let(:order_id) { '1' }
    let(:order_url) { "/orders/#{order_id}" }
    let(:mailer) { double(Mailer, deliver: nil) }

    before do
      controller.stub(:authenticate)
      controller.stub(:url_for).with(order).and_return(order_url)
      Order.stub(:find).with(order_id).and_return(order)
      Mailer.stub(:order_shipped).with(order).and_return(mailer)
    end

    it 'delivers the order fulfilled mail' do
      post :create, order_id: order_id
      expect(mailer).to have_received(:deliver)
    end

    it 'redirects to the order page' do
      post :create, order_id: order_id
      expect(response).to redirect_to(order_url)
    end
  end
end
