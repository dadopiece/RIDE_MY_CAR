class PagesController < ApplicationController
  def home
  end

  def dashboard
    @cars = current_user.cars
  end
end
