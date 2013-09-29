require "spec_helper"

describe AvailabilitiesController do
  describe "POST #bulk_change" do
    let(:user) { user }
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
end