class RidesController < ApplicationController

  get '/rides' do
  if logged_in?
    @rides = Ride.all
    erb :'/rides/index'
  else
    redirect to '/login'
  end
end

  get '/rides/new' do
  if logged_in?
    erb :'/rides/new'
  else
    redirect to '/login'
  end
end

  post '/rides/new' do
    if params.empty?
          flash[:error] = "All fields must be filled in"
          redirect '/rides/new'

    elsif logged_in? && !params.empty?
          @ride = current_user.rides.create(:title => params[:title], :location => params[:location], :description => params[:description], :ride_distance => params[:ride_distance], :ride_date=> params[:ride_date])
       if @ride.save
          redirect "/rides/#{@ride.id}"
       else
           flash[:error] = "Your project could not be saved. Try again!"
          redirect '/rides/new'
          end
      else
          flash[:error] = "You must be logged in to see the projects index."
          redirect '/login'
          end
          current_user.save
        end


    get '/rides/:id' do
    if logged_in?
       @rides = Ride.find_by_id(params[:id])
       erb :'/rides/show'
     else
        flash[:erro] = "You must be logged in"
        redirect to '/login'
     end
   end



    get '/rides/:id/edit' do
         @rides = Ride.find_by_id(params[:id])
    if logged_in? && current_user.rides.include?(@rides)
       erb :'/rides/edit'
    else
      flash[:erro] = "You must be logged in"
      redirect to '/login'
      end
    end

    patch '/rides/:id' do
        @rides = current_user.rides.find_by_id(params[:id])
    if params[:title] == "" || params[:location] == "" || params[:description] == "" || params[:ride_distance] == "" || params[:ride_date] == ""
       @rides.update(title: params[:title], location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
       redirect "/rides/#{@rides.id}"
    else
       redirect "/rides/#{@rides.id}/edit"
       end
    end

    delete '/rides/:id/delete' do
      if logged_in?
        @rides = Ride.find_by_id(params[:id])
    if @rides.user_id ==  current_user then @rides.delete else redirect '/login' end
        else
            flash[:error] = "You must be logged in."
            redirect '/login'
        end
        redirect '/rides'
    end
end
