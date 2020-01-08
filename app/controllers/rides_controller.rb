class RidesController < ApplicationController
 get "/rides" do
    @ride = Ride.all
    erb :"/rides/rides"
  end

  post '/rides' do
    @ride = current_user.rides.new(location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
    if @ride.save
      redirect to "/rides/#{@ride.slug}"
    else
      redirect to '/artist/new'
    end
  end

 get "/rides/new" do
    if logged_in?
      erb : "/rides/new_rides"
    else
     redirect to '/'
  end
end

get '/rides/:slug' do
   @ride = Ride.findy_by_slug(params[:slug])
   erb :'/rides/show_rides'
 end

get '/rides/:slug/edit'
 @ride = Ride.findy_by_slug(params[:slug])
 if logged_in? && current_user.rides.include?(@ride)
 else
   redirect to "/rides/#{@ride.slug}"
 end
end

patch '/rides/:slug' do
  @ride = Ride.findy_by_slug(params[:slug])
  @ride.location = params[:location]
  @ride.description = params[:description]
  @ride.ride_distance = params[:ride_distance]
  @ride.ride_date = params[:ride_date]
  if 



  t.string :location
  t.text :description
  t.string :ride_distance
  t.string :ride_date

  # POST: /rides
  post "/rides" do
    redirect "/rides"
  end

  # GET: /rides/5
  get "/rides/:id" do
    erb :"/rides/show.html"
  end

  # GET: /rides/5/edit
  get "/rides/:id/edit" do
    erb :"/rides/edit.html"
  end

  # PATCH: /rides/5
  patch "/rides/:id" do
    redirect "/rides/:id"
  end

  # DELETE: /rides/5/delete
  delete "/rides/:id/delete" do
    redirect "/rides"
  end
end
