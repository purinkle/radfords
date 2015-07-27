require "rails_helper"

describe OrdersHelper do
  describe '#show_order_button' do
    subject { helper.show_order_button(viewed) }

    let(:viewed) { false }

    it 'returns "btn-warning"' do
      expect(subject).to eql('btn-warning')
    end

    context 'when the order has been viewed' do
      let(:viewed) { true }

      it 'returns "btn-success"' do
        expect(subject).to eql('btn-success')
      end
    end
  end
end
