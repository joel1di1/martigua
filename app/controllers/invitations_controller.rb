class InvitationsController < ApplicationController
  def create

    if params[:match_id]
      match_ids = [*params[:match_id]]
      Match.ask_for_availability(match_ids)
    elsif params[:training_id]
      training_ids = [*params[:training_id]]
      Training.ask_for_availability(training_ids)
    end
      
    flash[:notice] = 'Les invitations vont être envoyées'
    redirect_to coach_home_path
  end
end
