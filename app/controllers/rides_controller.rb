class RidesController < ApplicationController

  get '/rides' do
    if logged_in?
      @rides = Ride.all
      erb :'/rides/index_rides'
    else
      redirect to '/login'
    end
  end
end


#
#   get '/rides' do
#     if logged_in?
#       erb :'/rides/new'
#     else
#       redirect to '/login'
#     end
#   end
#
#   post '/rides/new' do
#    if logged_in?
#      if params[:title] == "" ||params[:location] == "" || params[:description] == "" || params[:ride_distance] == "" || params[:ride_date] == ""
#          flash[:error] = "All fields must be filled in"
#          redirect to '/rides/new'
#        else
#          @ride = current_user.rides.create(:title => params[:title], :location => params[:location], :description => params[:description], :ride_distance => params[:ride_distance], :ride_date=> params[:ride_date])
#            if @ride.save
#              redirect to "/rides/#{@ride.id}"
#          else
#            flash[:error] = "Your input could not be saved. Try again!"
#            redirect '/rides/new'
#            end
#          end
#        else
#          flash[:error] = "You must be logged In !"
#          redirect '/login'
#      end
#    end
#
#
# get '/rides/:slug' do
#     if logged_in?
#         @rides = Ride.find_by_slug(params[:slug])
#         erb :'rides/show'
#       else
#           redirect to '/login'
#         end
#       end
#     end
#
# get '/rides/:id' do
#     if logged_in?
#        @rides = current_user.rides.find_by_id(params[:ride_id])
#        erb :'/rides/show'
#      else
#         flash[:erro] = "You must be logged In"
#         redirect to '/login'
#      end
#
#  get '/rides/:id/edit' do
#  @ride = Ride.find_by_id(params[:id])
#   if current_user == @ride
#     erb :'/rides/edit'
#   else
#     redirect "/rides"
#   end
# end
#
#
#     patch '/rides/:id' do
#       @ride = current_user.rides.find(params[:id])
#       if params[:title] != "" ||params[:location] != "" || params[:description] != "" || params[:ride_distance] != "" || params[:ride_date] != ""
#       @ride.update(title: params[:title], location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
#         redirect "/rides/#{@ride.id}"
#       else
#         redirect "/rides/#{@ride.id}/edit"
#       end
#         end
#
#         delete '/rides/:id/delete' do
#           @ride = Ride.find_by_id(params[:id])
#           if logged_in? && current_user.rides.include?(@ride)
#             @ride.delete
#               redirect to 'rides/new'
#           else
#             redirect to 'rides/new'
#           end
#       end
#
