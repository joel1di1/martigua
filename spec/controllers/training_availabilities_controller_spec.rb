require "spec_helper"

describe TrainingAvailabilitiesController do

  describe 'POST #set' do
    let(:user) { create :user }
    let(:training) { create :training }
    let(:coach) { create :user, :coach }
    let(:availability) { ['1', '0'].sample }

    subject { post :set, id: user.id, training_id: training.id, availability: availability }

    context 'with current_user signed in' do
      let(:mock_training) { double }
      before { sign_in user }
      before { Training.should_receive(:find).with(training.id.to_param).and_return(mock_training) }
      before { User.any_instance.should_receive(:change_training_availability!).with(mock_training, availability) }

      it { should redirect_to root_path }
    end

    context 'with admin signed in' do
      let(:mock_training) { double }
      before { sign_in coach }
      before { Training.should_receive(:find).with(training.id.to_param).and_return(mock_training) }
      before { User.any_instance.should_receive(:change_training_availability!).with(mock_training, availability) }

      it { should redirect_to root_path }
    end

    context 'with other signed in' do
      let(:other_user) { create :user }
      
      before { sign_in other_user }
      before { User.any_instance.should_receive(:change_training_availability!).never }

      it { should redirect_to root_path }
    end

  end
end