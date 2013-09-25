require "spec_helper"

describe Commitment do
  it { should validate_presence_of(:team) }
  it { should validate_presence_of(:championship) }
end