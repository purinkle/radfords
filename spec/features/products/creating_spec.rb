require "rails_helper"

module Features
  describe "creating products" do
    let(:options) { {} }
    let(:page) { NewProductPage.new(options) }

    it "creates products" do
      sign_in
      page.visit

      page.create_product

      expect(page).to be_product_page
      expect(page).to have_flash("You successfully created a product")
    end

    context "when there is no title" do
      let(:options) { { title: "" } }

      it "does not create a product" do
        sign_in
        page.visit

        page.create_product

        expect(page).to be_new_product_page
        expect(page).to have_error("Title can't be blank")
      end
    end
  end
end
