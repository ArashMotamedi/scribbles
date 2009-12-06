class HomeController < ApplicationController

  # Main landing page
  def index
  end

  # Login
  def login
    @current_user = Account.find_by_name_and_password(params[:username], params[:password])
    if @current_user
      # Log user in
      session[:user_id] = @current_user.id
    else
      flash.now[:pw_warning] = "Wrong username or password"
    end
  end

end
