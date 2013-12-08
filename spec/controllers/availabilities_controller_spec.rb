require "spec_helper"

describe AvailabilitiesController do
  let(:user) { create :user }

  describe "POST #bulk_change" do
    let(:match_1) { create :match, :futur}
    let(:match_2) { create :match, :futur}
    let(:match_3) { create :match, :futur}
    let(:matches) { [match_1, match_2, match_3] }
    let(:match_ids) { matches.map(&:id) }

    it 'change availabilities for all specified matches' do
      # sign_in user
      
      # User.any_instance.should_receive(:change_all_availabilities).with(match_ids)

      # post :bulk_change, id: match_ids
    end

  end

  describe 'POST #set' do
    let(:coach) { create :user, :coach }
    let(:match) { create :match }
    let(:match_id) { match.id }
    let(:availability) { 1 }

    subject { post :set, match_id: match_id, id: user.to_param, availability: availability }

    context 'with coach' do
      let(:mock_user) { double }
      before { sign_in coach }
      before { User.should_receive(:find).with(user.to_param).and_return(mock_user) }
      before { mock_user.should_receive(:change_availability!) }

      its(:code) { should eq '302' }
    end


  end
end