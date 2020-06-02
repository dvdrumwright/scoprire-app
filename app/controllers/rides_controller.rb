class RidesController < ApplicationController

  get '/rides' do
        authorize
        @ride = Ride.all
        erb :'rides/index_rides'
    end

    get '/rides/new' do
        authorize
        erb :'rides/new'
    end

  post '/runs' do
        authorize
        u = current_user
        u.runs.build(title: params[:title], location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
        raise PostSiteError.new if !u.save
        # redirect '/users/#{u.id}'
        redirect '/rides'
    end

    delete '/rides/:id' do
        ride = Ride.find_by(id: params[:id])
        authorize_user(ride)
        u = current_user
        if ride
          ride.destroy
            redirect "/cyclists/#{u.id}"
        end
    end

    get '/rides/:id/edit' do
        @ride = Ride.find_by(id: params[:id])
        authorize_user(  @ride )
        erb :'rides/edit'
    end

    patch '/rides/:id' do
        u = current_user
        @ride = Ride.find_by(id: params[:id])
        authorize_user(@ride)
        @ride.update(title: params[:title], location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
        redirect "/cyclists/#{u.id}"
    end
end
