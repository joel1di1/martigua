class TrainingAvailabilitiesController < InheritedResources::Base

  skip_before_filter :verify_authenticity_token, only: [:bulk_change]

  belongs_to :user
  belongs_to :training

  def create
    @training = Training.find params[:training_availability][:training_id]
    @available = TrainingAvailability.create training: @training, user: current_user, available: params[:training_availability][:available]
    redirect_to request.env["HTTP_REFERER"] || root_path
  end

  def update
    @available = TrainingAvailability.find params[:id]

    @available.update_attributes available: (params[:available] == '1')

    redirect_to request.env["HTTP_REFERER"] || root_path
  end

  def set
    user = User.find params[:id]

    if user == current_user || current_user.is_coach?
      training = Training.find params[:training_id]

      user.change_training_availability!(training, params[:availability])
    end
    redirect_to request.env["HTTP_REFERER"] || root_path
  end

  def permitted_params
    params.permit(:training_availability => [:user_id, :training_id, :available])
  end

  def bulk_change
    if params[:id_present]
      current_user.change_all_training_availabilities(params[:id], true)
      current_user.change_all_training_availabilities(params[:id_present] - [*params[:id]], false)
    else
      current_user.change_all_training_availabilities(params[:id], params[:available] == '1')
    end
    redirect_to root_path
  end

end
