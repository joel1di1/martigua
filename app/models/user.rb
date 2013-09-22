class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, 
         :trackable, :validatable,
         :confirmable

  validates_presence_of :email, :first_name

  before_validation :set_default_password
  before_validation :ensure_authentication_token
 
  protected 

    def set_default_password
      self.password = (0...8).map { (65 + rand(26)).chr }.join if self.password.blank? && self.encrypted_password.blank?
    end

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
