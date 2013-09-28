class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  helper_method :current_club

  protected

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
