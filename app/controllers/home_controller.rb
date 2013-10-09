class HomeController < ApplicationController

  def index
    @club = Club.find_by_name 'Martigua' 

    @teams = @club.teams.order('name ASC')

    @last_matches = @teams.map(&:last_match).uniq
    @next_matches = @teams.map(&:next_match).uniq
    @next_trainings = @club.next_trainings
  end

end
