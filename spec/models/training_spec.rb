require "spec_helper"

describe Training do

  let(:training) { create :training, date: 3.days.from_now }
  let(:nb) { [2, 3, 4, 5].sample }

  describe '#available_players' do
    subject { training.available_players }

    context 'with somes availables' do
      before { (1..nb).each { create :training_availability, training: training, available: true } }

      its(:count) { should eq nb }
    end
  end

  describe '#non_available_players' do
    subject { training.non_available_players }

    context 'with somes availables' do
      before { (1..nb).each { create :training_availability, training: training, available: false } }

      its(:count) { should eq nb }
    end
  end

  describe '#cancel!' do
    before { training.should_receive(:notify_users_for_cancelation) }
    before { training.cancel!("some reason") }

    subject { training }

    its(:canceled?) { should eq true}
  end

  describe '#notify_users_for_cancelation' do
    let!(:users) { nb.times{ create :user }}

    # before { UserMailer.should_receive(:notify_user_for_training_cancelation).exactly(nb).times }
    
    subject { training.notify_users_for_cancelation_without_delay } 

    it { should eq nb }
  end

end