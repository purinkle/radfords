require "rails_helper"

describe SuppliersController do
  let(:supplier_params) do
    {
      'address' => '1 High Street',
      'name' => 'Alphonso\'s Deli',
      'telephone_number' => '01234 567890'
    }
  end

  describe "DELETE 'destroy'" do
    it "destroys the supplier" do
      supplier = Supplier.new
      allow(controller).to receive(:authenticate)
      allow(Supplier).to receive(:find) { supplier }

      expect(supplier).to receive(:destroy)

      delete :destroy, params: { id: "1" }
    end

    it "redirects to the outlets page" do
      supplier = Supplier.new
      allow(controller).to receive(:authenticate)
      allow(Supplier).to receive(:find) { supplier }

      delete :destroy, params: { id: "1" }

      expect(response).to redirect_to outlets_path
    end

    it "sets the notice flash" do
      supplier = Supplier.new
      allow(controller).to receive(:authenticate)
      allow(Supplier).to receive(:find) { supplier }

      delete :destroy, params: { id: "1" }

      expect(flash[:notice]).to eql "You successfully deleted the supplier."
    end
  end

  describe "POST 'create'" do
    it "saves the supplier" do
      supplier = Supplier.new
      allow(controller).to receive(:authenticate)
      allow(Supplier).to receive(:new) { supplier }

      expect(supplier).to receive(:save!)

      post :create, params: { supplier: supplier_params }
    end

    it "redirects to the outlets page" do
      supplier = Supplier.new
      allow(supplier).to receive(:save!) { true }
      allow(controller).to receive(:authenticate)
      allow(Supplier).to receive(:new) { supplier }

      post :create, params: { supplier: supplier_params }

      expect(response).to redirect_to outlets_path
    end

    it "sets the notice flash" do
      supplier = Supplier.new
      allow(supplier).to receive(:save!) { true }
      allow(controller).to receive(:authenticate)
      allow(Supplier).to receive(:new) { supplier }

      post :create, params: { supplier: supplier_params }

      expect(flash[:notice]).to eql "You successfully created a supplier."
    end
  end

  describe "PUT 'update'" do
    let(:supplier) { Supplier.new }

    before do
      allow(supplier).to receive(:update_attributes!).
        with(supplier_params).
        once.
        and_return(true)
    end

    it "updates the supplier's attributes" do
      allow(controller).to receive(:authenticate)
      allow(Supplier).to receive(:find) { supplier }

      expect(supplier).to receive :update_attributes!

      put :update, params: { id: "1", supplier: supplier_params }
    end

    it "redirects to the outlets page" do
      allow(controller).to receive(:authenticate)
      allow(Supplier).to receive(:find) { supplier }
      allow(supplier).to receive(:update_attributes!)

      put :update, params: { id: "1", supplier: supplier_params }

      expect(response).to redirect_to outlets_path
    end

    it "sets the notice flash" do
      allow(controller).to receive(:authenticate)
      allow(Supplier).to receive(:find) { supplier }
      allow(supplier).to receive(:update_attributes!)

      put :update, params: { id: "1", supplier: supplier_params }

      expect(flash[:notice]).to eql "You successfully updated the supplier."
    end
  end
end
