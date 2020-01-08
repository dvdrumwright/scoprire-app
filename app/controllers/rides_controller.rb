class RidesController < ApplicationController

 get "/rides" do
    @ride = Ride.all
    erb :'/rides/rides'
  end

post '/rides' do
    @ride = current_user.rides.new(title: params[:title], location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
    if @ride.save
      redirect to "/rides/#{@ride.slug}"
    else
      redirect to '/artist/new'
    end
  end

get "/rides/new" do
    if logged_in?
      erb :"/rides/new_rides"
    else
     redirect to '/'
  end
end

get '/rides/:slug' do
 @ride = Ride.findy_by_slug(params[:slug])
 erb :'/rides/show_rides'
  end
 end


get '/rides/:slug/edit'
 @ride = Ride.findy_by_slug(params[:slug])
 if logged_in? && current_user.rides.include?(@ride)
  erb :'/rides/edit_rides'
 else
   redirect to "/rides/#{@ride.slug}"
  end



patch '/rides/:slug' do
  @ride = Ride.findy_by_slug(params[:slug])
  @ride.title = params[:title]
  @ride.location = params[:location]
  @ride.description = params[:description]
  @ride.ride_distance = params[:ride_distance]
  @ride.ride_date = params[:ride_date]
  if logged_in? && current_user.rides.include?(@ride)
    @ride.save
   redirect to  :'/rides/edit_rides'
  else
    redirect to "/rides/#{@ride.slug}"
   end
 end

   delete "/cyclists/:slug/:id/delete" do
      @ride = Ride.findy_by_slug(params[:slug])
       if logged_in? && current_user.rides.include?(@ride)
         @ride.posts.each do |post|
           post.delete
         end
         redirect to "/cylists/#{current_user.id}"
       else
         redirect to "/rides/#{@ride.slug}"
       end
     end
