require "rails_helper"

RSpec.describe OrderForm do
  it { is_expected.to validate_presence_of(:address_city) }
  it { is_expected.to validate_presence_of(:address_line_1) }
  it { is_expected.to validate_presence_of(:address_post_code) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }

  describe ".model_name" do
    it "is the form's naming-related information" do
      model_name = OrderForm.model_name

      expect(model_name).to have_attributes(
        cache_key: "orders",
        collection: "orders",
        element: "order",
        i18n_key: :order,
        name: "Order",
        param_key: "order",
        plural: "orders",
        route_key: "orders",
        singular: "order",
      )
    end
  end

  describe "#id" do
    it "is nil" do
      form = build_form

      id = form.id

      expect(id).to be_nil
    end

    context "when we've saved the form" do
      it "is the ID of the created order" do
        form = build_form
        form.save

        id = form.id

        expect(id).to eq Order.last.id
      end
    end
  end

  describe "#save" do
    context "when the form is valid" do
      it "is true" do
        form = build_form

        save = form.save

        expect(save).to be(true)
      end

      it "creates a new order" do
        basket = create_basket(5_00)
        form = build_form(
          address_city: "Testville",
          address_post_code: "TE5 7TE",
          basket: basket,
          email: "customer@example.com",
          name: "Test Customer",
        )

        form.save

        expect(Order.last).to have_attributes(
          address: <<~"ADDRESS".chomp,
            Testville
            TE5 7TE
          ADDRESS
          basket: basket,
          email: "customer@example.com",
          name: "Test Customer",
        )
      end

      it "charges the customer" do
        form = build_form(
          basket: create_basket(5_00),
          customer_id: "TEST_CUSTOMER_ID",
        )

        form.save

        expect(Stripe::Charge).to have_received(:create).with(
          amount: 5_00,
          currency: "gbp",
          customer: "TEST_CUSTOMER_ID",
          description: /Payment for #\d+/,
        )
      end

      it "sends an 'order received' mail" do
        form = build_form

        form.save

        expect(ActionMailer::Base.deliveries.count).to eq 1
      end
    end

    context "when the form is invalid" do
      it "is false" do
        form = build_form(name: "")

        save = form.save

        expect(save).to be(false)
      end

      it "doesn't create any orders" do
        form = build_form(name: "")

        form.save

        expect(Order.last).to be_nil
      end

      it "doesn't charge the customer" do
        form = build_form(name: "")

        form.save

        expect(Stripe::Charge).not_to have_received(:create)
      end

      it "doesn't send an 'order received' mail" do
        form = build_form(name: "")

        form.save

        expect(ActionMailer::Base.deliveries.count).to be_zero
      end
    end
  end

  def build_form(
    address_city: "Testville",
    address_line_1: "1 Test Street",
    address_post_code: "TE5 7TE",
    basket: create_basket,
    card_cvc: "817",
    card_exp_month: "10",
    card_exp_year: "2023",
    card_number: "4242424242424242",
    customer_id: "TEST_CUSTOMER_ID",
    email: "customer@example.com",
    name: "Test Customer"
  )
    stub_charge(
      amount: basket.total_price.cents,
      customer: stub_customer(
        card: stub_card(
          cvc: card_cvc,
          exp_month: card_exp_month,
          exp_year: card_exp_year,
          number: card_number,
        ),
        email: email,
        id: customer_id,
      ),
    )
    OrderForm.new(
      address_city: address_city,
      address_line_1: address_line_1,
      address_post_code: address_post_code,
      basket: basket,
      card_cvc: card_cvc,
      card_exp_month: card_exp_month,
      card_exp_year: card_exp_year,
      card_number: card_number,
      email: email,
      name: name,
    )
  end

  def create_basket(amount = 5_00)
    create(:line_item, price: Money.new(amount)).basket
  end

  def stub_card(cvc:, exp_month:, exp_year:, number:)
    double(:card).tap do |card|
      allow(Stripe::Token).to receive(:create).with(
        card: {
          cvc: cvc,
          exp_month: exp_month,
          exp_year: exp_year,
          number: number,
        },
      ).and_return(card)
    end
  end

  def stub_customer(card:, email:, id:)
    double(:customer, id: id).tap do |customer|
      allow(Stripe::Customer).to receive(:create).with(
        card: card,
        description: /Customer for #\d+/,
        email: email,
      ).and_return(customer)
    end
  end

  def stub_charge(amount:, customer:)
    allow(Stripe::Charge).to receive(:create).with(
      amount: amount,
      currency: "gbp",
      customer: customer.id,
      description: /Payment for #\d+/,
    )
  end
end
