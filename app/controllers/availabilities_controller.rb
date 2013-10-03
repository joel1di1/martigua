class AvailabilitiesController < InheritedResources::Base

  skip_before_filter :verify_authenticity_token, only: [:bulk_change]

  belongs_to :user
  belongs_to :match

  def create
    @match = Match.find params[:availability][:match_id]
    @availability = Availability.create match: @match, user: current_user, availability: params[:availability][:availability]
    redirect_to request.env["HTTP_REFERER"] || root_path
  end

  def update
    @availability = Availability.find params[:id]

    @availability.update_attributes availability: (params[:availability] == '1')

    redirect_to request.env["HTTP_REFERER"] || root_path
  end

  def permitted_params
    params.permit(:availability => [:user_id, :match_id, :availability])
  end

  def bulk_change
    if params[:id_present]
      current_user.change_all_availabilities(params[:id], true)
      current_user.change_all_availabilities(params[:id_present] - params[:id], false)
    else
      current_user.change_all_availabilities(params[:id], params[:availability] == '1')
    end
    flash[:notice] = 'Tes dispos ont bien été enregistrées !'
    redirect_to root_path
  end

end
