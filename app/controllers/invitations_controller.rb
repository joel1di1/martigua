class InvitationsController < ApplicationController
  def create
    match_ids = params[:match_id]

    Match.ask_for_availability(match_ids)

    flash[:notice] = 'Les invitations vont être envoyées'
    redirect_to root_path
  end
end
