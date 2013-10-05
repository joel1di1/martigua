require 'heroku-api'

class ScaleCommand

  def self.workers! quantity
    if Rails.env.production?
      heroku = Heroku::API.new(:username => ENV['HEROKU_USER'], :password => ENV['HEROKU_PWD'])
      heroku.post_ps_scale(ENV['HEROKU_APP_NAME'], 'worker', quantity)
    end
  end

  def self.scale_workers_down!
    self.workers! 0 unless Delayed::Job.count > 1
  end

end
