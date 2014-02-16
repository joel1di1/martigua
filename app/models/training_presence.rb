class TrainingPresence < ActiveRecord::Base

  #1 : present
  #2 : retard annoncé
  #3 : retard non annoncé
  #4 : absent non annoncé
  #5 : absent

  LABELS = {1 => "Présence", 2 => "Retard annoncé", 3 => "Retard non annoncé", 4 => "Abscence non annoncée", 5 => "Abscence annoncée"}
  VALUES = {1 => 50, 2 => 35, 3 => 20, 4 => -40, 5 => 0}

  after_save :update_score_event

  belongs_to :training
  belongs_to :user
  has_one :score_event

  protected
    def update_score_event
      score_event_tmp = score_event
      if score_event_tmp
        score_event_tmp.update_attributes label: label_for, value: value_for
      else
        create_score_event
      end
    end

    def label_for
      "#{LABELS[status]} à l'entrainement du #{training.date.to_s(:long)}"
    end
    def value_for
      VALUES[status]
    end

    def create_score_event
      ScoreEvent.create! user: user, label: label_for, value: value_for, training_presence: self
    end

end
