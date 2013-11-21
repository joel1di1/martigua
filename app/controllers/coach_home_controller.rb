class CoachHomeController < ApplicationController

  before_filter :only_coachs

  def index
    @club = Club.find_by_name 'Martigua' 
    @teams = @club.teams.order('name ASC')

    @next_matches = @club.next_matches
    @next_trainings = @club.next_trainings
    @users_without_cotis = User.active.without_cotis
    @users_without_certif = User.active.without_certif
  end

end
