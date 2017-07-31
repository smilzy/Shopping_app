class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception
  
  protected
  
  def authorize
    # unless User.find_by(id: session[:user_id])
    #   redirect_to login_url, notice: "Please log in"
    # end
    unless admin_user_signed_in?
      redirect_to new_admin_user_session_url, notice: "Please log in"
    end
  end
  
end
