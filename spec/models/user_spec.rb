require "spec_helper"

describe User do
  it { should validate_presence_of(:email) }

  describe '#create' do
    subject { lambda { create :user } }

    it { should change(ActionMailer::Base.deliveries, :count).by(1) }
  end

end