require "spec_helper"

describe Team do
  it { should belong_to(:club) }
  it { should validate_presence_of(:name) }
end