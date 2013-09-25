require "spec_helper"

describe UsersController do

  let(:user) { create :user }

  describe 'routing' do
    it "routes /users to users#index" do
      expect(:get => "/users").to route_to(
        :controller => "users",
        :action => "index"
      )
    end
  end

end
