class SelectionsController < ApplicationController
  before_filter :only_coachs

  def update
    match = Match.find params[:id]
    users_to_remove = User.where(id: [*params[:remove_player]])
    users_to_add = User.where(id: [*params[:add_player]])
    match.selection.users = match.selection.users - users_to_remove + users_to_add
    redirect_to match
  end
end
