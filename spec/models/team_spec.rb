require "spec_helper"

describe Team do
  it { should belong_to(:club) }
  it { should validate_presence_of(:name) }

  let(:team) { create :team }

  describe '#last_match' do
    subject { team.last_match }

    context 'with no match' do
      it { should be_nil }
    end

    context 'with a futur match' do
      let!(:futur_match) { create :match, :futur, local_team: team }

      it { should be_nil }

      context 'with two finished match' do
        let!(:finished_match_1) { create :match, :finished, local_team: team, starting_time: 3.days.ago }
        let!(:finished_match_2) { create :match, :finished, local_team: team, starting_time: 8.days.ago }

        it { should_not be_nil }
        it { should eq finished_match_1 }
      end
    end
  end

  describe '#matches' do

    subject { team.matches }

    context 'with a few matches' do
      let!(:finished_match_1) { create :match, :finished, local_team: team }
      let!(:finished_match_2) { create :match, :finished, visitor_team: team }
      let!(:futur_match_1) { create :match, :futur, local_team: team }
      let!(:futur_match_2) { create :match, :futur, visitor_team: team }
      let!(:futur_match_3) { create :match, :futur, visitor_team: team }

      before { 3.times { create :match } }

      its(:size) { should eq 5 }
      it { should include finished_match_1 }
      it { should include finished_match_2 }
      it { should include futur_match_1 }
      it { should include futur_match_2 }
      it { should include futur_match_3 }
    end
  end

  describe '#match_on' do
    let(:match_day)     { create :match_day, start_date: 4.days.from_now, end_date: 5.days.from_now }

    subject { team.match_on(match_day) }

    context 'with no match on match days' do
      it { should_not be_nil }
      its(:exempt?) { should eq true }
    end

    context 'with several match days' do
      
      let(:match_day_2)     { create :match_day, start_date: 8.days.from_now, end_date: 9.days.from_now }
      let!(:futur_match_1)  { create :match, match_day: match_day, local_team: team }
      let!(:futur_match_2)  { create :match, match_day: match_day_2, local_team: team}
      let!(:finished_match) { create :match, :finished, local_team: team }

      it { should_not be_nil }
      its(:exempt?) { should eq false }
      it { should eq futur_match_1 }
    end
  end

end