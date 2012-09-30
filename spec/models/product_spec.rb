require 'spec_helper'

describe Product do
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:image_url) }
  it { should allow_mass_assignment_of(:title) }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
end
