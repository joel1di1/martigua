class ScoreEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_presence
end
