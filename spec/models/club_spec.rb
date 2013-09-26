require "spec_helper"

describe Club do
  it { should have_many(:teams) }
  it { should validate_presence_of(:name) }

  let(:club) { create :club }

  let!(:team_1) { create :team, club: club}
  let!(:team_2) { create :team, club: club}
  let!(:team_3) { create :team, club: club}

  let!(:other_1) { create :team }
  let!(:other_2) { create :team }
  let!(:other_3) { create :team }


  describe '#last_matches' do
    
    subject { club.last_matches }

    context 'with 3 teams' do
      context 'with no previous matches' do
        its(:size) { should eq 3 }
        its(:first) { should be_nil }
        its(:second) { should be_nil }
        its(:third) { should be_nil }
      end

      context 'with 3 previous matches' do
        let!(:match_1) { create :match, :finished, local_team: team_1, visitor_team: team_1 }
        let!(:match_2) { create :match, :finished, local_team: team_2, visitor_team: team_2 }
        let!(:match_3) { create :match, :finished, local_team: team_3, visitor_team: team_3 }

        its(:size) { should eq 3 }

        it 'should includes the 3 matches' do
          assert subject - [match_1, match_2, match_3] == []
        end
      end
    end

  end

end