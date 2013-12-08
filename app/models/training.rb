class Training < ActiveRecord::Base
  belongs_to :location
  has_many :training_availabilities

  scope :nexts, -> { where('date < ?', 7.days.from_now).where('date > ?', Time.now) }
  scope :passed, -> { where('date < ?', Time.now) }

  def available_players
    training_availabilities.includes(:user).where(available: true).map(&:user)
  end

  def non_available_players
    training_availabilities.includes(:user).where(available: false).map(&:user)
  end

  def uncertain_players
    User.active - training_availabilities.map(&:user)
  end

  def cancel!(reason)
    notify_users_for_cancelation
    update_attribute :canceled, true
  end

  def notify_users_for_cancelation
    User.all.map{ |u| UserMailer.delay.notify_user_for_training_cancelation(self, u) }.count
  end
  handle_asynchronously :notify_users_for_cancelation

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
