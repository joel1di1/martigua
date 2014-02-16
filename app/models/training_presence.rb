class TrainingPresence < ActiveRecord::Base

  #1 : present
  #2 : retard annoncé
  #3 : retard non annoncé
  #4 : absent non annoncé
  #5 : absent


  belongs_to :training
  belongs_to :user

  protected
    def collection
      @trainings ||= end_of_association_chain.includes(training_availabilities: :user).order('date ASC')
    end

end
