class VieDeClubController < ApplicationController
  def index
    @users = User.active
    @users = @users.sort_by{|user| user.score}.reverse
  end
end
