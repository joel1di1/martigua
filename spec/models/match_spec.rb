require "spec_helper"

describe Match do
  it { should belong_to(:local_team) }
  it { should belong_to(:visitor_team) }
  it { should validate_presence_of(:local_team) }
  it { should validate_presence_of(:visitor_team) }

end