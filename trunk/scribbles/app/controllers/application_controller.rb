# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  ### CONSTANTS ###
  DEFAULT_DOC_NAME = "Default"
  
  ### Below are protected methods ###
  protected
  def redirect_if_logged_in
    get_logged_in_user
    if @current_user
      redirect_to "/#{@current_user.name}"
    end
  end
  
  def get_logged_in_user
    if not session[:user_id]
      return
    end
    @current_user = Account.find_by_id(session[:user_id])
  end
end
