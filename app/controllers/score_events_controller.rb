class ScoreEventsController < InheritedResources::Base

  before_filter :only_coachs

  def permitted_params
    params.permit(:score_event => [:user_id, :label, :value])
  end

end
