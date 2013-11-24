namespace :mails do

  task :send_daily_mails => :environment do
    today = Date.today

    next_in_7 = MatchDay.next_in_7
    if today.sunday? && next_in_7.start_date < 7.days.from_now
      Match.ask_for_availability(next_in_7.matches.map(&:id), true)
    elsif today.tuesday? && next_in_7.start_date < 7.days.from_now
      Match.ask_for_availability(next_in_7.matches.map(&:id))
    elsif today.wednesday? && next_in_7.start_date < 7.days.from_now
      Match.ask_for_availability(next_in_7.matches.map(&:id))
    elsif today.saturday?
      Training.ask_for_availability(Training.nexts.map(&:id))
    end
  end

end
