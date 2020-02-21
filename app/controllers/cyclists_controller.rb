require 'bcrypt'
require 'sinatra'

class CyclistsController < ApplicationController

  configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

  get '/signup' do
    if !logged_in?
        erb :'/cyclists/new'
    else
        redirect '/rides'
    end
   end

   get '/login' do
     if logged_in?
        redirect '/rides'
      else
        erb :'/cyclists/login'
      end
    end

   post '/login' do
    user = Cyclist.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect  "/rides"
     else
       redirect "/signup"
    end
  end

   post '/signup' do
     if params[:username] == "" || params[:password] == "" || params[:email] == ""
        redirect '/signup'
     else
        @user = Cyclist.create(username: params[:username], password: params[:password], email: params[:email])
        @user.save
        session[:user_id] = @user.id
        erb :'/rides/new'
        # redirect '/rides'
        end
      end

    get '/logout' do
      if logged_in?
            session.destroy
            redirect to '/login'
        else
          redirect '/'
       end
     end

   end
