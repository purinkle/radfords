require 'spec_helper'

describe ProductDecorator do
  before { ApplicationController.new.set_current_view_context }

  context "#large_image" do
    let(:decorator) do
      ProductDecorator.new(stub)
    end

    before(:each) do
      decorator.stub(
        h: stub(image_tag: stub),
        model: stub(id: stub, image_url: stub)
      )
    end

    it "gets the decorator's model" do
      decorator.should_receive(:model).twice.with(no_args)
      decorator.large_image
    end

    it "gets the model's ID" do
      decorator.model.should_receive(:id).with(no_args)
      decorator.large_image
    end

    it "gets the model's image URL" do
      decorator.model.should_receive(:image_url).with(no_args)
      decorator.large_image
    end

    it "gets the decorator's helper" do
      decorator.should_receive(:h).with(no_args)
      decorator.large_image
    end

    it "creates an image tag" do
      decorator.h.should_receive(:image_tag).with(
        "products/#{decorator.model.id}/large/#{decorator.model.image_url}"
      )

      decorator.large_image
    end

    it "returns the image tag" do
      decorator.large_image.should == decorator.h.image_tag
    end
  end

  context "#small_image" do
    let(:decorator) do
      ProductDecorator.new(stub)
    end

    before(:each) do
      decorator.stub(
        h: stub(image_tag: stub),
        model: stub(id: stub, image_url: stub)
      )
    end

    it "gets the decorator's model" do
      decorator.should_receive(:model).twice.with(no_args)
      decorator.small_image
    end

    it "gets the model's ID" do
      decorator.model.should_receive(:id).with(no_args)
      decorator.small_image
    end

    it "gets the model's image URL" do
      decorator.model.should_receive(:image_url).with(no_args)
      decorator.small_image
    end

    it "gets the decorator's helper" do
      decorator.should_receive(:h).with(no_args)
      decorator.small_image
    end

    it "creates an image tag" do
      decorator.h.should_receive(:image_tag).with(
        "products/#{decorator.model.id}/small/#{decorator.model.image_url}"
      )

      decorator.small_image
    end

    it "returns the image tag" do
      decorator.small_image.should == decorator.h.image_tag
    end
  end
end
