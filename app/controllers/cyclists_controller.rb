require 'bcrypt'
require 'sinatra'

class CyclistsController < ApplicationController

  configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

  get '/cyclists/:slug' do
      @cyclist = Cyclist.find_by_slug(params[:slug])
      erb :'cyclists/show_cyclists'
    end

  get '/signup' do
    if !logged_in?
    erb :'/cyclists/new'
  else
      redirect '/rides'
   end
  end

  post '/signup' do
   if params[:username] == "" || params[:email] == "" || params[:password] == ""
     flash[:signup_page_message] = "Sorry, can you make sure to fill out all three fields: Name, Email, and Password?"
     redirect to '/signup'
   end

   if !Cyclist.new(:username => params[:username], :password => params[:password]).valid?
     flash[:signup_page_message] ="Oops, sorry but that name is already taken!"
     redirect to '/signup'
   elsif !Cyclist.new(:email => params[:email], :password => params[:password]).valid?
     flash[:signup_page_message] ="Oops, sorry but that email address is already taken!"
     redirect to '/signup'
   else
     @user = Cyclist.new(:username => params[:username], :email => params[:email], :password => params[:password])
     @user.save
     session[:user_id] = @user.id
     redirect to '/rides'
   end
 end

 get '/login' do
     if !logged_in?
       erb :'cyclists/login'
     else
       redirect to '/rides'
     end
   end

   post '/login' do
     user = Cyclist.find_by(:username => params[:username])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect to "/rides"
     else
       flash[:message_for_login_page] = "Oops, your username & password combo is incorrect; click here to sign in as a new user."
        redirect to '/login'
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
 end
