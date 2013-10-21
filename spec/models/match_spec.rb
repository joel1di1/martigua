require "spec_helper"

describe Match do
  it { should belong_to(:local_team) }
  it { should belong_to(:visitor_team) }
  it { should belong_to(:match_day) }
  it { should validate_presence_of(:local_team) }
  it { should validate_presence_of(:visitor_team) }

  let(:match) { create :match }

  describe '#exempt?' do
    subject { match.exempt? }

    context 'with standard match default' do
      it { should eq false }
    end

    context 'with exempt match' do 
      let(:team) { create :team }
      let(:match_day) { create :match_day }
      let(:match) { Match.exempt(team, match_day) }

      it { should eq true }
    end
  end
end