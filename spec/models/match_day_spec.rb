require "spec_helper"

describe MatchDay do
  it { should have_many(:matches) }

  describe '.next' do 

    subject { MatchDay.next }

    context 'with several futur match_days' do 
      let!(:match_day_0) { create :match_day, :finished }
      let!(:match_day_1) { create :match_day, start_date: 1.days.ago, end_date: 1.days.from_now }
      let!(:match_day_2) { create :match_day, start_date: 6.days.from_now, end_date: 7.days.from_now }
      let!(:match_day_3) { create :match_day, start_date: 8.days.from_now, end_date: 9.days.from_now }

      it { should eq match_day_1}
    end
  end

  describe '.previous' do 

    subject { MatchDay.previous }

    context 'with several previous match_days' do 
      let!(:match_day_0) { create :match_day, :futur }
      let!(:match_day_1) { create :match_day, start_date: 1.days.ago, end_date: 1.days.from_now }
      let!(:match_day_2) { create :match_day, start_date: 8.days.ago, end_date: 7.days.ago }
      let!(:match_day_3) { create :match_day, start_date: 10.days.ago, end_date: 9.days.ago }

      it { should eq match_day_1}
    end
  end

end