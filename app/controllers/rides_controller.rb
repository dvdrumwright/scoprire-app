class RidesController < ApplicationController

  get '/rides' do

    if logged_in?
      @rides = Ride.all
      erb :'/rides/rides'
    else
        flash[:message] = "Please login first"
        redirect to '/login'
      end
  end

end
