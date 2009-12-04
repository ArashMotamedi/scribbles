class HomeController < ApplicationController

  # Main landing page
  def index
  end

  # Login
  def login
    flash.now[:pw_warning] = "Wrong username or password"
  end

end
