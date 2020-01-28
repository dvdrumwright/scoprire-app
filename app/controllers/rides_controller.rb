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

  get 'rides/new' do
    if logged_in?
      erb :'rides/new'
    else
      redirect to '/login'
    end
  end

   


end
