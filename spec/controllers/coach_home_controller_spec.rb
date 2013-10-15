require "spec_helper"

describe CoachHomeController do

  let!(:martigua) { create :club, name: "Martigua" }
  let!(:martigua_1) { create :team, name: "Martigua 1", club: martigua }
  let!(:martigua_2) { create :team, name: "Martigua 2", club: martigua }
  let!(:martigua_3) { create :team, name: "Martigua 3", club: martigua }
 
  describe "GET #index" do
    let(:password) { 'secret' }
    let(:user) { create :user, password: password}

    before { sign_in user }

    before { get :index }

    context 'with non coach' do 
      describe 'response' do
        subject { response }
        its(:code) { should eq '302' }
      end 
    end
    context 'with coach' do 
      let(:user) { create :user, password: password, is_coach: true}
      describe 'response' do
        subject { response }
        its(:code) { should eq '200' }
      end 
    end

    # describe 'assigns' do
    #   subject { assigns }
    #   it { should include :next_matches }
    #   it { should include :next_trainings }
    #   it { should include :last_matches }
    # end 
  end
end

