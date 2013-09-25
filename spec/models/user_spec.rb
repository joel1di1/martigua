require "spec_helper"

describe User do
  it { should validate_presence_of(:email) }
  # it { should validate_presence_of(:authentication_token) }  // does not work ???

  let(:user) { create :user } 

  describe '#create' do
    context 'with authentication_token nil' do
      subject { create :user, authentication_token: nil }
      its(:authentication_token) { should_not be_nil }
    end

    describe 'sends change password email' do 
      subject { lambda { create :user } }
      it { should change(ActionMailer::Base.deliveries, :count).by(1) }
    end
  end

  describe "#to_param" do
    subject { user.to_param }

    it { should eq "#{user.id} #{user.full_name}".parameterize }
  end

  describe "#full_name" do
    let(:first_name) { Faker::Name.first_name }
    let(:last_name)  { Faker::Name.last_name }
    let(:nickname)  { Faker::Name.last_name }

    let(:user) { create :user, first_name: first_name, last_name: last_name, nickname: nickname }

    subject { user.full_name }

    context 'with nickname' do
      it { should eq nickname }
    end

    context 'with no nickname' do
      let(:nickname)  { nil }

      context 'with first_name and last_name' do
        it { should eq "#{first_name} #{last_name}" }
      end

      context 'with no first_name' do
        let(:first_name) { nil }

        it { should eq user.email }

        context 'and with no last_name' do
          let(:last_name) { nil }

          it { should eq user.email }
        end
      end
      context 'with no last_name' do
        let(:last_name) { nil }

        it { should eq user.first_name }
      end
    end
  end
end