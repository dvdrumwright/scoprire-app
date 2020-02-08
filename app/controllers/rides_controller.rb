class RidesController < ApplicationController

  get '/rides/:slug' do
   if logged_in?
       @rides= Ride.find_by_slug(params[:slug])
      erb :'/rides/index'
  end

  get '/rides' do
   if logged_in?
     erb :'/rides/new'
   else
     redirect to '/login'
   end
 end

 post '/rides' do
   if logged_in?
    @cyclists = Cyclist.find_by_id[:user_id]
    @rides = @cyclists.rides.create(:location => params[:location], :description => params[:description], :ride_distance => params[:ride_distance],:ride_date => params[:ride_date])
    @rides = current_user
    if @rides.save
       redirect to "/rides/#{@rides.id}"
   else
     redirect to '/rides/new'
   end
    else
      redirect to '/'
   end
 end

 get '/rides/:id' do
   if logged_in?
    @ride = Ride.find_by_id(params[:ride_id])
  else
    @rides = Cyclist.new
  end
   erb :'/rides/show'
 end


 get '/rides/:id/edit' do
   if logged_in?
     @rides  = Ride.find_by_id(params[:ride_id])
   if logged_in? && current_user.rides.include?(@rides)
      erb :'/rides/edit'
   else
     redirect to "/rides/#{ @rides.ride_id}"
   end
 else
   redirect to '/login'
 end
end
#
 patch '/rides/:id' do
   if @rides = Cyclist.find_by_id(params[:id])

    @rides.cyclist = Cyclist.find_or_create_by(username: params[:cyclist][:username], user_id: current_user.id)
    @rides.location = params[:location]
    @rides.ride_date = Date.parse(params[:ride_date])
    @rides.description = params[:description]
    @rides.title = params[:title]
 elsif
     logged_in? && current_user.cyclists.include?(@rides)
     @ride.save
     redirect to "/cyclists/#{@rides.id}"
   else
     redirect to "/rides/#{ @rides.id}"
   end
 end
end

 delete '/rides/:id/delete' do
   if logged_in?
        @rides = Ride.find_by_id(params[:ride_id])
        @rides && @rides.cyclists == current_user
        @rides.delete
      redirect to '/rides'
   else
     redirect to '/login'
     end
   end
 end
