# == Schema Information
#
# Table name: events
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  takes_place_on :date
#  location       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require "rails_helper"

describe Event do
  subject(:event) { described_class.new(attributes) }

  let(:attributes) { attributes_for(:event) }

  let(:valid_attributes) do
    {
      name: "Rob's Birthday",
      takes_place_on: "7 June 1985",
      location: "Leighton Hospital, Crewe"
    }
  end

  it "creates a new instance given valid attributes" do
    expect(described_class.create!(valid_attributes)).to be_persisted
  end

  it "requires a name" do
    no_name_event = described_class.create(valid_attributes.merge(name: ""))
    expect(no_name_event).not_to be_valid
  end

  it "requires a date" do
    no_date_event = described_class.create(valid_attributes.merge(takes_place_on: ""))
    expect(no_date_event).not_to be_valid
  end

  it "accepts valid dates" do
    dates = ["29 September 2011", "29/09/11", "29-SEP-2011"]

    dates.each do |date|
      valid_date_event = described_class.create(valid_attributes.merge(takes_place_on: date))
      expect(valid_date_event).to be_valid
    end
  end

  it "rejects invalid dates" do
    dates = %w[friday 13 user@example.com]

    dates.each do |date|
      invalid_date_event = described_class.create(valid_attributes.merge(takes_place_on: date))
      expect(invalid_date_event).not_to be_valid
    end
  end

  it "requires a location" do
    no_location_event = described_class.create(valid_attributes.merge(location: ""))
    expect(no_location_event).not_to be_valid
  end

  describe "#takes_place_on_date" do
    it "returns the stored date, where takes_place_on returns a string", :aggregate_failures do
      event = described_class.new(valid_attributes.merge(takes_place_on: "29 September 2011"))

      expect(event.takes_place_on_date).to eql(Date.new(2011, 9, 29))
      expect(event.takes_place_on).to be_a(String)
    end
  end

  describe "#to_s" do
    let(:name) { attributes.fetch(:name) }

    it "returns the event's name" do
      expect(event.to_s).to eql(name)
    end
  end
end
