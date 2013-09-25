require "spec_helper"

describe HomeController do
  describe "GET #index" do
    let(:password) { 'secret' }
    let(:user) { create :user, password: password}

    before { sign_in user }
    before { get :index }

    subject { response }
  end
end

