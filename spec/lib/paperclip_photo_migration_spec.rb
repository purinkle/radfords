require "rails_helper"
require Rails.root.join("lib/paperclip_photo_migration").to_s

describe PaperclipPhotoMigration do
  subject(:migration) do
    described_class.new(bucket: Aws::S3::Bucket.new(name: "photos", client: client), out: out, err: err)
  end

  let(:client) { Aws::S3::Client.new(stub_responses: true) }
  let(:err) { StringIO.new }
  let(:out) { StringIO.new }
  let!(:product) do
    Product.create!(title: "Plum Jam", photo_file_name: "jam.png", photo_content_type: "image/png")
  end

  def photo_attached?
    Product.with_attached_photo.find(product.id).photo.attached?
  end

  context "when the photo is still at its Paperclip key" do
    before do
      client.stub_responses(:get_object, body: File.binread(PhotoFixture::PATH), content_type: "image/png")
    end

    it "succeeds" do
      migration.run

      expect(migration).to be_succeeded
    end

    it "attaches it to the product" do
      migration.run

      expect(photo_attached?).to be(true)
    end

    it "asks S3 for the key Paperclip built from the product id" do
      migration.run

      partition = format("%09d", product.id).scan(/\d{3}/).join("/")
      expect(client.api_requests.last[:params])
        .to include(bucket: "photos", key: "product/photos/#{partition}/original/jam.png")
    end
  end

  context "when nothing is stored at the Paperclip key" do
    before { client.stub_responses(:get_object, "NoSuchKey") }

    it "fails" do
      migration.run

      expect(migration).not_to be_succeeded
    end

    it "reports the missing photo" do
      migration.run

      expect(err.string).to include("#{product.id}: nothing at product/photos/")
    end
  end
end
