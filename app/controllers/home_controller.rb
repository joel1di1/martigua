class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index
    @club = Club.find_by_name 'Martigua' 

    @teams = @club.teams.order('name ASC')

    @last_matches = @teams.map(&:last_match)
  end

end
