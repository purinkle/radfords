require "rails_helper"

module Features
  describe 'fulfil order' do
    let(:order) { FactoryGirl.create(:order) }
    let(:order_page) { OrderPage.new(order) }
    let(:mail) { ActionMailer::Base.deliveries.last }

    it 'sends an email to the customer' do
      sign_in

      order_page.visit_page
      order_page.fulfil

      expect(mail.to).to eql([order.email])
      expect(mail.from).to eql(['rob@purinkle.co.uk'])
      expect(mail.subject).to eql("Shipping confirmation for order #{order.id}")
      expect(page).to have_content('email sent')
    end
  end
end
