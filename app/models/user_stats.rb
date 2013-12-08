class UserStats
  def self.users_attendence
    trainings = Training.passed
    matches = Match.finished
    User.includes(:availabilities).includes(:training_availabilities).all.map do |user|
      training_attendence = 0.0
      trainings.each do |training|
        training_attendence += 1 if user.available_for? training
      end
      training_attendence = training_attendence / trainings.count

      match_attendence = 0.0
      matches.each do |match|
        match_attendence += 1 if user.available_for? match
      end
      match_attendence = match_attendence / matches.count

      [user.full_name, training_attendence, match_attendence]
    end
  end

  def self.training_attendence
    trainings = Training.passed
    User.includes(:availabilities).includes(:training_availabilities).all.map do |user|
      training_attendence = 0.0
      trainings.each do |training|
        training_attendence += 1 if user.available_for? training
      end
      training_attendence = training_attendence / trainings.count

      match_attendence = 0.0
      matches.each do |match|
        match_attendence += 1 if user.available_for? match
      end
      match_attendence = match_attendence / matches.count

      [user.full_name, training_attendence, match_attendence]
    end
  end

end