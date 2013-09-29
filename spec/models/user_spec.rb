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


  describe '#available_for?' do
    let(:match) { create :match }

    subject { user.available_for? match}

    context 'when user has not indicated his availability' do
      it { should be_nil }
    end

    context 'when user has indicated his availability' do
      let!(:user_availability) { create :availability, user: user, match: match, availability: availability }

      context 'as available' do
        let(:availability) { true }

        it { should_not be_nil }
        it { should be_true }
      end
      context 'as not available' do
        let(:availability) { false }

        it { should_not be_nil }
        it { should be_false }
      end
    end
  end

  describe '#change_all_availabilities' do
    let(:match_1) { create :match, :futur}
    let(:match_2) { create :match, :futur}
    let(:match_3) { create :match, :futur}
    let(:matches) { [match_1, match_2, match_3] }
    let(:match_ids) { matches.map(&:id) }
    let(:available) { [true, false].sample }

    subject do
      user.change_all_availabilities(match_ids, available)
      [user.available_for?(match_1), user.available_for?(match_2), user.available_for?(match_3)].uniq
    end

    context 'with no previous availability' do
      it { should eq [available] }
    end
    context 'with previous availabilities' do
      let!(:availability_1) { create :availability, user: user, match: match_1 }
      let!(:availability_2) { create :availability, user: user, match: match_2, availability: true }
      let!(:availability_3) { create :availability, user: user, match: match_3, availability: false }

      it { should eq [available] }
    end
  end

end