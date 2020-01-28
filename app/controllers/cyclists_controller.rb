require 'bcrypt'
require 'sinatra'

class CyclistsController < ApplicationController
  get '/signup' do
      redirect '/rides' if logged_in?
      erb :"cyclists/new"

  end

  post "/signup" do
   #validate username and email uniqueness
     Cyclist.invalid?(params[:user_id])
     flash[:message] = "Sorry, that username or email is already taken."
     redirect to '/signup'
   end


   # params cannot be empty
  redirect to '/signup' if fields_empty?(params)

    @cyclist = Cyclist.create(:username => params[:username],
         :email => params[:email],
         :password => params[:password])

  #assign session user_id to new user
  session[:user_id] =   @cyclist.id
  redirect '/rides'
end

get '/logout' do
    session.clear
    redirect '/'
  end

  get "/login" do
    redirect '/rides' if logged_in?
    erb :"cyclists/login"
  end

  post "/login" do
    # params cannot be empty
    redirect to '/login' if fields_empty?(params)

    # authenticate username and password
    @cyclist = Cyclist.find_by(username: params[:username])
      if  @cyclist &&  @cyclist.authenticate(params[:password])
        session[:user_id] =@cyclist.id
        redirect "/rides"
      else
        flash[:message] = "Incorrect username or password. Please log in again."
        redirect '/login'
      end
  end

  get "/cyclists/:slug" do
    if !logged_in?(session)
        flash[:message] = "You must be logged in to view your profile."
        redirect '/'
    else
        # find user by slugified username
        @user = Cyclist.find_by_slug(params[:slug])

        # only the current user can view their own users/:slug page
        if @user && @user.id == current_user(session).id
          erb :"/cyclists/show"
        else
          flash[:message] = "Sorry, you cannot view another user's profile."
          redirect '/login'
      end
    end
  end



end
