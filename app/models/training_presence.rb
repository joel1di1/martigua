class TrainingPresence < ActiveRecord::Base
  belongs_to :training
  belongs_to :user

  protected
    def collection
      @trainings ||= end_of_association_chain.includes(training_availabilities: :user).order('date ASC')
    end

end
