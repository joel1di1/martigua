require "spec_helper"

describe HomeController do

  let!(:martigua) { create :club, name: "Martigua" }
  let!(:martigua_1) { create :team, name: "Martigua 1", club: martigua }
  let!(:martigua_2) { create :team, name: "Martigua 2", club: martigua }
  let!(:martigua_3) { create :team, name: "Martigua 3", club: martigua }
  let!(:match_day) { create :match_day, :futur }
 
  describe "GET #index" do
    let(:password) { 'secret' }
    let(:user) { create :user, password: password}

    before { sign_in user }

    before { get :index }

    describe 'response' do
      subject { response }
      its(:code) { should eq '200' }
    end 

    describe 'assigns' do
      subject { assigns }
      it { should include :next_matches }
      it { should include :next_trainings }
      it { should include :last_matches }
    end 
  end
end

