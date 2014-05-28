require 'spec_helper'

module Features
  describe 'fulfil order' do
    let(:email) { user.email }
    let(:order) { FactoryGirl.create(:order) }
    let(:order_page) { OrderPage.new(order) }
    let(:mail) { ActionMailer::Base.deliveries.last }
    let(:password) { user.password }
    let(:signin_page) { SigninPage.new(email, password) }
    let(:user) { FactoryGirl.create(:user) }

    it 'sends an email to the customer' do
      visit signin_path
      signin_page.sign_in

      order_page.visit_page
      order_page.fulfil

      expect(mail.to).to eql([order.email])
      expect(mail.from).to eql(['denise@radfordsofsomerford.co.uk'])
      expect(mail.subject).to eql('Shipping confirmation for your order')
      expect(page).to have_content('email sent')
    end
  end
end
