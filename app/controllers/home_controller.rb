class HomeController < ApplicationController

  def index
    @club = Club.find_by_name 'Martigua' 

    @last_matches = @club.last_matches
    @next_matches = @club.next_matches
    @next_trainings = @club.next_trainings
  end

end
