class RidesController < ApplicationController


  get '/rides' do
          if logged_in?
              @rides = Ride.all
              erb :'/rides/show'
          else
              redirect '/login'
          end
      end

      get '/rides/new' do
          if logged_in?
              erb :'/rides/new'
          else
              redirect '/login'
          end
      end

      post '/rides' do
          if params.empty?
              flash[:error] = "All fields must be filled in"
              redirect '/rides/new'
          elsif logged_in? && !params.empty?
                 @rides= current_user.projects.create(title: params[:title], location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
              if @rides.save
                  redirect "/rides/#{@rides.id}"
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
              flash[:error] = "You must be logged in to view projects."
              redirect '/login'
          end
      end

      get '/rides/:id/edit' do
          @rides = Ride.find_by_id(params[:id])
          if logged_in? && current_user.projects.include?(@rides)
              erb :'/rides/edit'
          else
              flash[:error] = "You must be logged in to edit a project."
              redirect '/login'
          end
      end

      patch '/rides/:id' do
        @rides = Ride.find_by_id(params[:id])
          if params.empty?
              flash[:error] = "All fields must be filled in"
              redirect "/rides/#{@rides.id}/edit"
          elsif logged_in? && !params.empty? && current_user.projects.include?(@rides)
            @rides.update(title: params[:title], location: params[:location], description: params[:description], ride_distance: params[:ride_distance], ride_date: params[:ride_date])
              redirect "/rides/#{@rides.id}"
          else
              flash[:error] = "You must be logged in."
              redirect '/login'
          end

      end


    delete '/rides/:id/delete' do
          if logged_in?
              @ride = Ride.find_by_id(params[:id])
              if @ride.user == current_user then @ride.delete else redirect '/login' end
          else
              flash[:error] = "You must be logged in."
              redirect '/login'
          end
          redirect '/rides'
      end
  end
