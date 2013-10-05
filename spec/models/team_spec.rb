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

  describe '#next_match' do
    subject { team.next_match }

    context 'with no match' do
      it { should be_nil }
    end

    context 'with a previous match' do
      let!(:futur_match) { create :match, :finished, local_team: team }

      it { should be_nil }

      context 'with two futurs match' do
        let!(:finished_match_1) { create :match, :futur, local_team: team, starting_time: 8.days.from_now }
        let!(:finished_match_2) { create :match, :futur, local_team: team, starting_time: 3.days.from_now }

        it { should_not be_nil }
        it { should eq finished_match_2 }
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

end