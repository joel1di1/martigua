require "spec_helper"

describe Club do
  it { should have_many(:teams) }
  it { should validate_presence_of(:name) }
end