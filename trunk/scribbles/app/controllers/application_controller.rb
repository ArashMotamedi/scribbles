# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  ### CONSTANTS ###
  DEFAULT_DOC_NAME = "My Document"
  
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
  
  # Creates a new temporary account and returns the account and the default doc for the account
  def create_temp_account(name)
    # Create the new account
    acc = Account.new
    acc.name = name
    acc.expiration = 7;
    acc.is_permanent = false
    acc.save!
    
    # Create the default doc for the account
    newAcc = Account.find_by_name(name)
    doc = create_document(newAcc)
    
    return newAcc,doc
  end
  
  # Creates
  def create_document(account)
    doc = Document.new
    doc.name = DEFAULT_DOC_NAME
    doc.account_id = account.id
    doc.body = ""
    doc.save!
    doc = Document.find_by_account_id(account.id)
  end
end
