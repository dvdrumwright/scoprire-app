

  class RidesController < ApplicationController

    get '/rides' do
    erb :'/rides/index'
  end


    post '/rides/new' do
       if params[:title] == "" || params[:location] == "" || params[:description] == "" || params[:ride_distance] == "" || params[:ride_date] == ""
          flash[:error] = "All fields must be filled in"
          redirect '/rides/new'
        end

    if !Ride.new(:title => params[:title], :location => params[:location], :description => params[:description], :ride_distance => params[:ride_distance], :ride_date=> params[:ride_date]).valid?
        flash[:signup_page_message] ="oops, this ride alrady exist"
        redirect to '/rides/new'
    elsif @ride = Ride.new(:title => params[:title], :location => params[:location], :description => params[:description], :ride_distance => params[:ride_distance], :ride_date=> params[:ride_date])
          @ride.save
        session[:user_id] = @ride.id
        redirect to '/rides'
        end
    end

    get '/rides/:id' do
        @rides = Ride.find_by_id(params[:id])
      redirect_if_not_loggedin
          if @rides
            if @rides.rides.cyclist == current_user
          erb :'/rides/show'
        else
             redirect to '/rides/new'
            end
          else
            redirect to '/rides'
        end
      end


    get '/rides/:id/edit' do
         @rides = Ride.find_by_id(params[:id])
    if logged_in? && current_user.rides.include?(@rides)
       erb :'/rides/edit'
    else
      redirect '/rides/new'
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
        @rides = Ride.find_by_id(params[:id])
    if current_user.rides.include?(@rides)
      @rides.delete
       redirect '/rides'
     else
        redirect '/rides'
      end
    end
  end
