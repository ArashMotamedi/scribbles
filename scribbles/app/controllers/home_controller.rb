class HomeController < ApplicationController

  # Main landing page
  def index
  end

  # Login
  def login
    flash.now[:pw_warning] = "Wrong username or password"
    @current_user = Account.find_by_name_and_password(params[:username], params[:password])
    if @current_user
      session[:user_id] = @current_user.id
      flash.now[:pw_warning] = @current_user.name
    end
  end

end
