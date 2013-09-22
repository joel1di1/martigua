require "spec_helper"

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  # it { should validate_presence_of(:authentication_token) }

  describe '#create' do
    context 'with authentication_token nil' do
      subject { create :user, authentication_token: nil }
      its(:authentication_token) { should_not be_nil }
    end

    describe 'sends confirmation email' do 
      subject { lambda { create :user } }
      it { should change(ActionMailer::Base.deliveries, :count).by(1) }
    end
  end

end