class ScoreEventsController < InheritedResources::Base

  def permitted_params
    params.permit(:score_event => [:user_id, :label, :value])
  end

end
