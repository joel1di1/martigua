class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, 
         :trackable, :validatable

  has_many :availabilities, dependent: :delete_all

  has_many :training_availabilities, dependent: :delete_all

  validates_presence_of :email, :authentication_token

  before_validation :ensure_authentication_token

  nilify_blanks

  after_create :send_invitation_mail

  scope :active, -> { where(active: true) }
 
  def password_required?
    # Password is required if it is being set, but not for new records
    if !persisted? 
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

  def send_invitation_mail
    self.send_reset_password_instructions
  end

  def full_name
    if nickname
      nickname
    elsif first_name && last_name
      "#{first_name} #{last_name}"
    elsif first_name
      first_name
    else
      email
    end
  end

  def to_param
    "#{id} #{full_name}".parameterize
  end

  def available_for?(match)
    availability_for(match).try(:availability)
  end

  def availability_for(match)
    availabilities.where(match_id: match.id).first
  end

  def training_availability_for(training)
    training_availabilities.where(training: training).first
  end

  def to_s
    full_name
  end

  def change_all_availabilities(match_ids, available)
    Availability.transaction do 
      Availability.where(user: self, match_id: match_ids).delete_all
      Match.where(id: match_ids).map do |match|
        Availability.create! user: self, match: match, availability: available
      end
    end
  end

  def change_all_training_availabilities(training_ids, available)
    TrainingAvailability.transaction do 
      TrainingAvailability.where(user: self, training_id: training_ids).delete_all
      Training.where(id: training_ids).map do |training|
        TrainingAvailability.create! user: self, training: training, available: available
      end
    end
  end

  def set_availability_for?(matches)
    matches = matches.compact.select{|match| !match.exempt?}
    matches.count == availabilities.where(match_id: matches.map(&:id)).count
  end

  def set_availability_for_trainings?(trainings)
    trainings = trainings.compact
    trainings.count == training_availabilities.where(training_id: trainings.map(&:id)).count
  end

  protected 

    def ensure_authentication_token
      if authentication_token.blank?
        self.authentication_token = generate_authentication_token
      end
    end
   
    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end

end
