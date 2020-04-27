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
        redirect '/cyclists/login'
     end
   end

   post '/cyclists/new' do
     if params[:username] == "" || params[:password] == "" || params[:email] == ""
        redirect '/cyclists/new'
      else
        @user = Cyclist.create(username: params[:username], password: params[:password], email: params[:email])
        @user.save
        session[:user_id] = @user.id
        erb :'/rides/new'
        end
      end

  get '/logout' do
    if logged_in?
        session.destroy
        redirect to '/login'
    else
        redirect to '/'
      end
    end

  get '/login' do
    if !logged_in?
       erb :'/cyclists/login'
    else
      redirect "rides/new"
      end
  end

 post '/cyclists/login' do
      user = Cyclist.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/rides"
    else
        flash[:error] = "Incorrect username or password. Please try again!"
        redirect "/login"
      end
    end





end
