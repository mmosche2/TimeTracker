class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
	@current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token] 
  end
  
  def signed_in?
	!current_user.nil?
  end
  
  def authorize
	redirect_to login_url, notice: "Not authorized" if current_user.nil?
  end


  
  helper_method :current_user
  helper_method :signed_in?
  
end
