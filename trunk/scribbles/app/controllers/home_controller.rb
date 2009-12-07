class HomeController < ApplicationController
  before_filter :redirect_if_logged_in

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
  
  # Create temp account
  def create_temp
    if params[:temp_account]
      redirect_to :controller => "documents", :pagename => params[:temp_account]
    end
  end

end
