class RidesController < ApplicationController


get '/rides/new' do
   if logged_in?
     erb :'/rides/new'
   else
     redirect to '/'
   end
 end

  post '/rides/new' do
    if params.empty?
      redirect '/rides/new'
    elsif logged_in? && !params.empty?
      @current_ride = current_user.rides.create(title: params[:title], location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
      if @current_ride.save
          redirect "/rides/#{@current_ride.id}"
        else redirect '/rides/new'
          end
          else
          flash[:error] = "You must be logged in to see the projects index."
           redirect '/login'
         end
           current_user.save
        end

    end
