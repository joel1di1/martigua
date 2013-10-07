class Training < ActiveRecord::Base
  belongs_to :location

  scope :nexts, -> { where('date < ?', 7.days.from_now).where('date > ?', Time.now) }

  class << self
    def ask_for_availability(training_ids)
      trainings = Training.where(id: [*training_ids].flatten).all
      User.where(active: true).each do |user| 
        UserMailer.delay.ask_for_training_availability(trainings, user)
      end
    end
    handle_asynchronously :ask_for_availability
  end
end
