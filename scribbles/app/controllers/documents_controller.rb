class DocumentsController < ApplicationController
  before_filter :get_logged_in_user
  
  # Variables
  # @current_user - The currently logged in user
  # @this_doc - The document that is displayed on the page
  
  def index
    # Get the account of this page
    accountOfThisPage = Account.find_by_name(params[:pagename])
    
    # If this page's account exists, get the default doc for the account
    if accountOfThisPage
      @this_doc = Document.find_by_account_id_and_name(accountOfThisPage.id, "default")
    # Else, create a new temporary account and default doc
    else
      # Method creates a temp account and returns the default doc
      @this_doc = create_temp_account(params[:pagename])
    end
  end
  
  def login
    @current_user = Account.find_by_name_and_password(params[:username], params[:password])
    if @current_user
      # Log user in
      session[:user_id] = @current_user.id
    else
      flash.now[:error] = "Wrong username or password"
    end
  end
  
  def logout
    session[:user_id] = @current_user = nil
  end
  
  #### Private methods below ####
  private
  
  # Creates a new temporary account and returns the default doc for the account
  def create_temp_account(name)
    # Create the new account
    acc = Account.new
    acc.name = name
    acc.expiration = 7;
    acc.is_permanent = false
    acc.save!
    
    # Create the default doc for the account
    newAcc = Account.find_by_name(name)
    doc = Document.new
    doc.name = "default"
    doc.account_id = newAcc.id
    doc.body = ""
    doc.save!
    
    return doc
  end

end
