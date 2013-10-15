class CoachHomeController < ApplicationController

  before_filter :only_coachs

  def index
    @club = Club.find_by_name 'Martigua' 
    @teams = @club.teams.order('name ASC')

    @next_matches = @teams.map(&:next_match).uniq
    @next_trainings = @club.next_trainings
  end

end
