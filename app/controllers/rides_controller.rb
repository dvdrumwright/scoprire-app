class RidesController < ApplicationController
  get '/rides/new' do
    if logged_in?
      erb :'/rides/new_rides'
    else
      redirect to '/'
    end
  end

  post '/rides' do
    @ride = Ride.new(usename: Cyclist.find_or_create_by(username: params[:cyclist][:username], user_id: current_user.id),
     location: params[:location],
      ride_date: Date.parse(params[:ride_date]),
        description: params[:description],
          title: params[:title])
    if  @ride.save && @ride.cyclist.valid?
      redirect to "/rides/#{@ride.id}"
    else
      redirect to '/rides/new'
    end
  end

  get '/rides/:id' do
     @ride = Ride.find_by_id(params[:id])
    erb :'/rides/show_cyclist'
  end

  get '/rides/:id/edit' do
   @ride = Ride.find_by_id(params[:id])
    if logged_in? && current_user.concerts.include?(@ride)
      erb :'/rides/new_rides'
    else
      redirect to "/rides/#{ @ride.id}"
    end
  end

  patch '/rides/:id' do
     @ride = Cyclist.find_by_id(params[:id])
     @ride.cyclist = Cyclist.find_or_create_by(username: params[:cyclist][:username], user_id: current_user.id)
     @ride.location = params[:location]
     @ride.ride_date = Date.parse(params[:ride_date])
     @ride.description = params[:description]
     @ride.title = params[:title]
  if logged_in? && current_user.cyclists.include?( @ride)
      @ride.save
      redirect to "/cyclists/#{ @ride.id}"
    else
      redirect to "/rides/#{ @ride.id}"
    end
  end

  delete '/rides/:id' do
    @ride = Ride.find_by_id(params[:id])
    if logged_in? && current_user.cyclists.include?(@ride)
      @ride.delete
      redirect to "/cyclist/#{current_user.id}"
    else
      redirect to "/rides/#{@ride.id}"
    end
  end
end
