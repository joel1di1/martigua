class Selection < ActiveRecord::Base
  belongs_to :match

  has_and_belongs_to_many :users
end
