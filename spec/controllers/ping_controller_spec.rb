require "spec_helper"

describe PingController do
  describe "GET #index" do
    subject { get :index }
    
    its(:code) { should eq "200" }
  end
end
