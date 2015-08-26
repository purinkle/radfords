require "rails_helper"

describe FulfilmentsController do
  describe 'POST "create"' do
    let(:order) { double(Order) }
    let(:order_id) { '1' }
    let(:order_url) { "/orders/#{order_id}" }
    let(:mailer) { double(Mailer, deliver_now: nil) }

    before do
      allow(controller).to receive(:authenticate)
      allow(controller).to receive(:url_for).with(order).and_return(order_url)
      allow(Order).to receive(:find).with(order_id).and_return(order)
      allow(Mailer).to receive(:order_shipped).with(order).and_return(mailer)
    end

    it 'delivers the order fulfilled mail' do
      post :create, order_id: order_id
      expect(mailer).to have_received(:deliver_now)
    end

    it 'redirects to the order page' do
      post :create, order_id: order_id
      expect(response).to redirect_to(order_url)
    end
  end
end
