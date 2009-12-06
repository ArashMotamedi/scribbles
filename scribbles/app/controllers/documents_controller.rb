class DocumentsController < ApplicationController
  def index
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
end
