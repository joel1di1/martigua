class PingController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    render json: {time: Time.now}
  end
end
