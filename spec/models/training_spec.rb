require "spec_helper"

describe Training do

  let(:training) { create :training, date: 3.days.from_now }

  describe '#available_players' do
    subject { training.available_players }

    context 'with somes availables' do

      let(:nb) { [2, 3, 4, 5].sample }

      before { (1..nb).each { create :training_availability, training: training, available: true } }

      its(:count) { should eq nb }
    end
  end

  describe '#non_available_players' do
    subject { training.non_available_players }

    context 'with somes availables' do

      let(:nb) { [2, 3, 4, 5].sample }

      before { (1..nb).each { create :training_availability, training: training, available: false } }

      its(:count) { should eq nb }
    end
  end

end