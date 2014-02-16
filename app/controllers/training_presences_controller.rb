class TrainingPresencesController < InheritedResources::Base

  def edit_list
    @training = Training.find params[:training_id]
    @available_players = @training.available_players.sort_by{|player| player.last_name}
  end

  def create
    @training = Training.find params[:training_id]
    params[:users].each do |key, value|
      user = User.find key
      training_presence = TrainingPresence.find_or_create_by user: user, training: @training
      training_presence.update_attribute :status, value
    end
    flash[:notice] = 'Présences mises à jour !'
    redirect_to edit_training_training_presences_path(training_id: @training.id)
  end

protected
  def collection
    if params[:training_id]
      @training_presences ||= end_of_association_chain.where(training_id: params[:training_id])
    else
      @training_presences ||= end_of_association_chain
    end
  end 
end
