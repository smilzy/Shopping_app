class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception
  
  protected
  
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
  
  after_destroy :ensure_an_admin_remains
  class Error < StandardError
  end
  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Can't delete last user"
    end
  end
end
