class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  helper_method :current_club

  before_filter :authenticate_user_or_token!

  protected

    def only_coachs
      redirect_to root_url unless current_user.try(:is_coach)
    end

    def authenticate_user_or_token!
      user = User.find_by_authentication_token(params[:user_token]) if params[:user_token]
      if user  
        sign_in user
      else
        authenticate_user!
      end
    end

    def layout_by_resource
      if devise_controller?
        'public'
      else
        'application'
      end
    end 

    def current_club
      @current_club ||= Club.find_by_name('Martigua')
    end

end
