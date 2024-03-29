class AccountsController < ApplicationController

  # Registration page
  def registration
    @acc = Account.new
  end
  
  # Register a user
  def register
    # Some validation
    #if not isValid(params)
    #  return
    #end
    
    # Validation done, now save it
    @newAcc = Account.new
    @newAcc.name = params[:name]
    @newAcc.password = params[:password]
    @newAcc.password_confirmation = params[:password2]
    @newAcc.email = params[:email]
    @newAcc.expiration = -1;
    @newAcc.is_permanent = true
    
    # Try to save
    if @newAcc.save
      # Log user in
      @current_user = Account.find_by_name(@newAcc.name)
      session[:user_id] = @current_user.id
      
      # Create default doc for account
      newDoc = Document.new
      newDoc.name = DEFAULT_DOC_NAME
      newDoc.account_id = @current_user.id
      newDoc.body = ""
      newDoc.lock_holder = ""
      newDoc.save
      
    # Save account failed, so show error message
    else
      err = @newAcc.errors.first
      flash.now[:reg_warning] = err[0].capitalize + " " + err[1]
    end
    
  end
  
  ### Below are private methods ###
  private
  
  # Method to do some validation
  def isValid(parameters)
    if not parameters[:password] == parameters[:password2]
      flash.now[:reg_warning] = "Passwords must be the same"
      return false
    end
    
    return true
  end
  
end
