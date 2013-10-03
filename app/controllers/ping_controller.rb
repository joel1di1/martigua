class PingController < ApplicationController
  skip_before_filter :authenticate_user_or_token!

  def index
    render json: {time: Time.now}
  end
end
