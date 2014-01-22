class TrainingsController < InheritedResources::Base

  before_filter :only_coachs, only: [:update]

  def permitted_params
    params.permit(:training => [:canceled, :cancelation_reason])
  end
  protected
    def collection
      @trainings ||= end_of_association_chain.includes(training_availabilities: :user).order('date ASC')
    end
end
