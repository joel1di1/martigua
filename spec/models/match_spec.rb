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

  describe 'selected_players' do
    let!(:non_selected_1) { create :user }
    let!(:non_selected_2) { create :user }
    let!(:selected_1) { create :user }
    let!(:selected_2) { create :user }

    before { match.selection.users << selected_1 }
    before { match.selection.users << selected_2 }

    subject { match.selected_players }

    it { should =~ [selected_1, selected_2] }
  end

  describe '#create' do
    let(:match) { build :match }

    subject { match.save!; match }

    its(:selection) { should_not be_nil }
  end

  describe '.ask_for_availability' do
    let!(:user) { create :user }

    context 'with 3 matches' do
      let(:match_1) { create :match }
      let(:match_2) { create :match }
      let(:match_3) { create :match }
      let(:matches) { [match_1, match_2, match_3] }
      let(:match_ids) { matches.map(&:id) }

      subject { Match.ask_for_availability_without_delay(match_ids) }

      it { should_not be_nil}
    end
  end
end