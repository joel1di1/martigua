namespace :mails do

  task :send_daily_mails => :environment do
    today = Date.today

    if today.sunday? && MatchDay.next.start_date < 7.days.from_now
      Match.ask_for_availability(MatchDay.next.matches.map(&:id), true)
    elsif today.tuesday? && MatchDay.next.start_date < 7.days.from_now
      Match.ask_for_availability(MatchDay.next.matches.map(&:id))
    elsif today.wednesday? && MatchDay.next.start_date < 7.days.from_now
      Match.ask_for_availability(MatchDay.next.matches.map(&:id))
    elsif today.saturday?
      Training.ask_for_availability(Training.nexts.map(&:id))
    end
  end

end
