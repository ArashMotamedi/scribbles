class AccountsController < ApplicationController

  # Registration page
  def registration
    @acc = Account.new
  end
  
  # Register a user
  def register
    # Some validation
    if not isValid(params)
      return
    end
    
    # Validation done, now save it
    @newAcc = Account.new
    @newAcc.name = params[:name]
    @newAcc.password = params[:password]
    @newAcc.email = params[:email]
    #if @newAcc.save
      flash[:reg_warning] = @newAcc.name + " " + @newAcc.password + " " + @newAcc.email
    #else
    #  flash[:reg_warning] = "User already exists, try another name"
    #end
    
  end
  
  #-- Below are private methods --
  private
  
  # Method to do some validation
  def isValid(parameters)
    if parameters[:name] == "" ||
      parameters[:password] == "" ||
      parameters[:password2] == "" ||
      parameters[:email] == ""
        flash[:reg_warning] = "All fields are required!"
        return false
    end
    if not parameters[:password] == parameters[:password2]
      flash[:reg_warning] = "Passwords must be the same!"
      return false
    end
    
    return true
  end
  
end
