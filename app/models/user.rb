class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, 
         :trackable, :validatable,
         :confirmable, :omniauthable

  validates_presence_of :email

  before_validation :set_default_password

  protected 

    def set_default_password
      self.password = (0...8).map { (65 + rand(26)).chr }.join if self.password.blank? && self.encrypted_password.blank?
    end

end
