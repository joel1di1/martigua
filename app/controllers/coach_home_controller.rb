class CoachHomeController < ApplicationController

  before_filter :only_coachs

  def index
    @club = Club.find_by_name 'Martigua' 
    @teams = @club.teams.order('name ASC')

    @next_trainings = @club.next_trainings
    @previous_trainings = Training.where('date < ?', 1.day.from_now).order('date DESC').limit(5)
    @users_without_cotis = User.active.without_cotis
    @users_without_certif = User.active.without_certif
  end

  def stats
    @users_attendence = UserStats.users_attendence
  end

end
