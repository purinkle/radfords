require 'spec_helper'

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
      controller.stub(:authenticate)
      Supplier.stub(find: supplier)

      supplier.should_receive(:destroy)

      delete :destroy, id: "1"
    end

    it "redirects to the outlets page" do
      supplier = Supplier.new
      controller.stub(:authenticate)
      Supplier.stub(find: supplier)

      delete :destroy, id: "1"

      expect(response).to redirect_to outlets_path
    end

    it "sets the notice flash" do
      supplier = Supplier.new
      controller.stub(:authenticate)
      Supplier.stub(find: supplier)

      delete :destroy, id: "1"

      expect(flash[:notice]).to eql "You successfully deleted the supplier."
    end
  end

  describe "GET 'new'" do
    it "creates a new supplier" do
      supplier = Supplier.new
      controller.stub(:authenticate)
      Supplier.stub(new: supplier)

      get :new

      expect(assigns(:supplier)).to be supplier
    end
  end

  describe "POST 'create'" do
    it "creates a new supplier" do
      supplier = Supplier.new
      supplier.stub(save!: true)
      controller.stub(:authenticate)
      Supplier.stub(new: supplier)

      post :create, supplier: supplier_params

      expect(assigns(:supplier)).to be supplier
    end

    it "saves the supplier" do
      supplier = Supplier.new
      controller.stub(:authenticate)
      Supplier.stub(new: supplier)

      supplier.should_receive(:save!)

      post :create, supplier: supplier_params
    end

    it "redirects to the outlets page" do
      supplier = Supplier.new
      supplier.stub(save!: true)
      controller.stub(:authenticate)
      Supplier.stub(new: supplier)

      post :create, supplier: supplier_params

      expect(response).to redirect_to outlets_path
    end

    it "sets the notice flash" do
      supplier = Supplier.new
      supplier.stub(save!: true)
      controller.stub(:authenticate)
      Supplier.stub(new: supplier)

      post :create, supplier: supplier_params

      expect(flash[:notice]).to eql "You successfully created a supplier."
    end

    context "when the supplier is not valid" do
      it "renders the new supplier page" do
        supplier = Supplier.new
        exception = ActiveRecord::RecordInvalid.new(supplier)
        supplier.stub(:save!).and_raise(exception)
        controller.stub(:authenticate)
        Supplier.stub(new: supplier)

        post :create, supplier: supplier_params

        expect(response).to render_template "new"
      end
    end
  end

  describe "GET 'edit'" do
    it "finds the supplier" do
      supplier = Supplier.new
      controller.stub(:authenticate)
      Supplier.stub(find: supplier)

      get :edit, id: "1"

      expect(assigns(:supplier)).to be supplier
    end
  end

  describe "PUT 'update'" do
    let(:supplier) { Supplier.new }

    before do
      supplier.stub(:update_attributes!).
        with(supplier_params).
        once.
        and_return(true)
    end

    it "finds the supplier" do
      controller.stub(:authenticate)
      Supplier.stub(find: supplier)

      put :update, id: "1", supplier: supplier_params

      expect(assigns(:supplier)).to be supplier
    end

    it "updates the supplier's attributes" do
      controller.stub(:authenticate)
      Supplier.stub(find: supplier)

      expect(supplier).to receive :update_attributes!

      put :update, id: "1", supplier: supplier_params
    end

    it "redirects to the outlets page" do
      controller.stub(:authenticate)
      Supplier.stub(find: supplier)

      put :update, id: "1", supplier: supplier_params

      expect(response).to redirect_to outlets_path
    end

    it "sets the notice flash" do
      controller.stub(:authenticate)
      Supplier.stub(find: supplier)

      put :update, id: "1", supplier: supplier_params

      expect(flash[:notice]).to eql "You successfully updated the supplier."
    end

    context "when the updated supplier is invalid" do
      it "renders the edit supplier page" do
        exception = ActiveRecord::RecordInvalid.new(supplier)
        supplier.stub(:update_attributes!).and_raise(exception)
        controller.stub(:authenticate)
        Supplier.stub(find: supplier)

        put :update, id: "1", supplier: supplier_params

        expect(response).to render_template "edit"
      end
    end
  end
end
