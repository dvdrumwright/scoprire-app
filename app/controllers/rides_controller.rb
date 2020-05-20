class RidesController < ApplicationController


get '/rides' do
  if logged_in?
    erb :'rides/index' 
end









  # get '/rides' do
  #   if logged_in?
  #       @rides = Ride.all
  #       erb :'rides/index_rides'
  #     else
  #         redirect to '/login'
  #       end
  #     end
  #
  # get '/rides' do
  #   if logged_in?
  #     erb :'/rides/new'
  #   else
  #     redirect to '/login'
  #   end
  # end

  post '/rides' do
    if logged_in?
      if params[:title] == "" ||params[:location] == "" || params[:description] == "" || params[:ride_distance] == "" || params[:ride_date] == ""
          flash[:error] = "All fields must be filled in"
          redirect to '/rides/new'
        else
          @ride = current_user.rides.create(:title => params[:title], :location => params[:location], :description => params[:description], :ride_distance => params[:ride_distance], :ride_date=> params[:ride_date])
            if @ride.save
              redirect to "/rides/#{@ride.id}"
          else
            flash[:error] = "Your input could not be saved. Try again!"
            redirect '/rides/new'
            end
          end
        else
          flash[:error] = "You must be logged In !"
          redirect '/login'
      end
    end

 get '/rides/:id' do
    if logged_in?
       @rides = Ride.find_by_id(params[:id])
       erb :'/rides/show'
     else
        flash[:erro] = "You must be logged In"
        redirect to '/login'
     end
   end

 get '/rides/:id/edit' do
      if logged_in?
         @rides = Ride.find_by_id(params[:id])

      if  @rides  && @rides.user == current_user
          erb :'/rides/edit'
        else
          redirect to '/rides'
        end
      else
        flash[:erro] = "You must be logged in"
        redirect to '/login'
        end
      end

    patch '/rides/:id' do
      if logged_in?
        if params.empty?
            redirect to "/rides/#{params[:id]}/edit"
          else
              @ride = Ride.find_by_id(params[:id])
              if  @ride && @ride.user == current_user
                if  @ride.update(:title => params[:title], :location => params[:location], :description => params[:description], :ride_distance => params[:ride_distance], :ride_date=> params[:ride_date])
                  redirect to "/rides/#{@ride.id}"
                else
                  redirect to "/rides/#{@ride.id}/edit"
                end
              else
                redirect to '/rides'
              end
            end
          else
            redirect to '/login'
          end
        end

 delete '/rides/:id/delete' do
   if logged_in?
     @ride = Ride.find_by_id(params[:id])
        if  @ride && @ride.user == current_user
            @ride.delete
        end
          redirect to '/rides'
        else
          redirect to '/login'
        end
      end
    end
