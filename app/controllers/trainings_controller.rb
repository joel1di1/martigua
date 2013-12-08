class TrainingsController < InheritedResources::Base

  before_filter :only_coachs, only: [:update]

  def permitted_params
    params.permit(:training => [:canceled, :cancelation_reason])
  end
end
