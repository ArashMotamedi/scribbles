class HomeController < ApplicationController
  before_filter :redirect_if_logged_in

  # Main landing page
  def index
  end

  # Login
  def login
    @current_user = Account.authenticate(params[:username], params[:password])
    if @current_user
      # Log user in
      session[:user_id] = @current_user.id
    else
      flash.now[:pw_warning] = "Wrong username or password"
    end
  end
  
  # Create temp account
  def create_temp
    render :update do |page|
      if not params[:temp_account] == ""
        page.redirect_to params[:temp_account]
      end
    end
  end

end
