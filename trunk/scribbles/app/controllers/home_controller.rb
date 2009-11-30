class HomeController < ApplicationController

  # Main landing page
  def index
  end

  # Login
  def login
    flash[:pw_warning] = "Incorrect username or password"
  end

end
