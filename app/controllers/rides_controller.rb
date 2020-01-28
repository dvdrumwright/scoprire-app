class RidesController < ApplicationController

  get '/rides' do
    if logged_in?
        erb :'/rides/new_ride'
    else
      redirect to '/'
    end
  end

  get '/rides/new_ride' do
    if logged_in?
      erb :'rides/new_ride'
    else
      redirect to '/login'
    end
  end

  post '/rides' do
    @ride = Ride.new(usename: Cyclist.find_or_create_by(username: params[:cyclist][:username], user_id: current_user.id),
     location: params[:location],
      ride_date: Date.parse(params[:ride_date]),
        description: params[:description],
          title: params[:title])
    if  @ride.save && @ride.cyclist.valid?
      redirect to "/rides/#{@ride.ride_id}"
    else
      redirect to '/rides/new'
    end
  end

  get '/rides/:id' do
    if logged_in?
     @ride = Ride.find_by_id(params[:ride_id])
    erb :'/rides/show_ride'
  end
end

  get '/rides/:id/edit' do
      if logged_in?
   @ride = Ride.find_by_id(params[:ride_id])
    if logged_in? && current_user.rides.include?(@ride)
      erb :'/rides/new_rides'
    else
      redirect to "/rides/#{ @ride.ride_id}"
    end
  else
    redirect to '/login'
  end
end
#
  patch '/rides/:id' do
    if @ride = Cyclist.find_by_id(params[:id])

     @ride.cyclist = Cyclist.find_or_create_by(username: params[:cyclist][:username], user_id: current_user.id)
     @ride.location = params[:location]
     @ride.ride_date = Date.parse(params[:ride_date])
     @ride.description = params[:description]
     @ride.title = params[:title]
  elsif
      logged_in? && current_user.cyclists.include?(@ride)
      @ride.save
      redirect to "/cyclists/#{ @ride.id}"
    else
      redirect to "/rides/#{ @ride.id}"
    end
  end
end

  delete '/rides/:id' do
    if logged_in?
       @ride = Ride.find_by_id(params[:ride_id])
       @ride && @ride.cyclists == current_user
       @ride.delete
       redirect to '/rides'
    else
      redirect to '/login'
      end
    end
