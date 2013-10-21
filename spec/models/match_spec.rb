require "spec_helper"

describe Match do
  it { should belong_to(:local_team) }
  it { should belong_to(:visitor_team) }
  it { should belong_to(:match_day) }
  it { should validate_presence_of(:local_team) }
  it { should validate_presence_of(:visitor_team) }

  describe '.to_come' do
    subject { Match.to_come }

    context 'with a finished match' do
      let!(:finished_match) { create :match, :finished }

      it { should be_empty }

      context 'with a defined scheduled match in 2 weeks' do
        let!(:scheduled_match) { create :match, :finished, starting_time: 2.weeks.from_now }

        it { should eq [scheduled_match] }

        context 'with a non scheduled match in 1 weeks' do
          let!(:we_scheduled_match) { create :match, :finished, between_day1: 6.days.from_now, between_day2: 7.days.from_now, starting_time: nil }

          it { should eq [scheduled_match, we_scheduled_match] }
        end
      end
    end

  end
end