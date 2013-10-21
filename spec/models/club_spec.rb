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
    let!(:match_day) { create :match_day, :finished }
    
    subject { club.last_matches }

    context 'with no previous matches' do
      its(:size) { should eq 3 }
      its(:first) { should_not be_nil }
      its(:second) { should_not be_nil }
      its(:third) { should_not be_nil }
    end

    context 'with 3 previous matches' do
      let!(:match_1) { create :match, match_day: match_day, local_team: team_1, visitor_team: other_1 }
      let!(:match_2) { create :match, match_day: match_day, local_team: team_2, visitor_team: other_2 }
      let!(:match_3) { create :match, match_day: match_day, local_team: team_3, visitor_team: other_3 }

      its(:size) { should eq 3 }

      it 'should includes the 3 matches' do
        assert subject - [match_1, match_2, match_3] == []
      end
    end
  end

  describe '#next_matches' do
    let!(:match_day) { create :match_day, :futur }

    subject { club.next_matches }

    context 'with 3 matches' do
      let!(:match_1) { create :match, match_day: match_day, local_team: team_1, visitor_team: other_1 }
      let!(:match_2) { create :match, match_day: match_day, local_team: other_2, visitor_team: team_2 }
      let!(:match_3) { create :match, match_day: match_day, local_team: team_3, visitor_team: other_3 }

      its(:size) { should eq 3 }

      it 'should includes the 3 matches' do
        assert subject - [match_1, match_2, match_3] == []
      end
    end
  end

  describe '#next_trainings' do

    subject { club.next_trainings }

    context 'with no trainings' do
      it { should eq [] }
    end
    context 'with two training in the next days' do
      let!(:training_1){ create :training, date: 1.day.from_now }
      let!(:training_2){ create :training, date: 4.day.from_now }
      let!(:training_3){ create :training, date: 9.day.from_now }

      its(:count) { should eq 2}
      it { should eq [training_1, training_2] }
    end
  end

end