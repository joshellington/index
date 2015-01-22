class IndexController < ApplicationController
  def home
    @neighborhoods = Neighborhood.all
    @parking_options = ParkingOption.all
    @categories = Category.all
  end
end
