class RidesController < ApplicationController

get '/rides' do
    if logged_in?
        @rides = Ride.all
        erb :'rides/index_rides'
      else
          redirect to '/login'
        end
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
       @rides = current_user.rides.find_by_id(params[:id])
       erb :'/rides/show'
     else
        flash[:erro] = "You must be logged In"
        redirect to '/login'
     end
   end

 get '/rides/:id/edit' do
   @item= Ride.find(params[:id])
  if current_user.rides.include?(@item)
    erb :'/rides/edit'
  else
    redirect "/rides/index_rides"
  end
end


    patch '/rides/:id' do
      @item = current_user.rides.find(params[:id])
      if params[:title] != "" ||params[:location] != "" || params[:description] != "" || params[:ride_distance] != "" || params[:ride_date] != ""
        @item.update(title: params[:title], location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
        redirect "/rides/#{@item.id}"
      else
        redirect "/rides/#{@item.id}/edit"
      end
        end
        binding.pry
        delete '/rides/:id/delete' do
          binding.pry
          @ride = Ride.find_by_id(params[:id])
          if logged_in? && current_user.rides.include?(@ride)
            @ride.delete
              redirect to 'rides/new'
          else
            redirect to 'rides/new'
          end
      end

  end
