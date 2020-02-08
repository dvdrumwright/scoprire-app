require 'bcrypt'
require 'sinatra'

class CyclistsController < ApplicationController

   get '/signup' do
      if !logged_in?
        erb :'/cyclists/new', locals: {message: "Please sign up before you sign in"}
      else
        redirect to '/index'
      end
    end
  
    post '/signup' do
       if params[:username] == "" || params[:email] == "" || params[:password] == ""
          flash[:sign_up] = "Please make sure to fill out all the fields"
          redirect to '/signup'
        end
        if @a = !Cyclist.new(:username => params[:username], :password => params[:password])
            @a.valid?
            flash[:sign_up] = "Sorry name is already taken !"
            redirect to '/signup'
        elsif Cyclist.new(:email => params[:email], :password => params[:password]).valid?
            flash[:sign_up] = "Sorry email address is already taken!"
            redirect to '/signup'
          else
            @user = Cyclist.new(:username => params[:username], :email => params[:email],  :password => params[:password])
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
        redirect '/rides'
      else
        flash[:message] = "Your Username or Password is Incorrect."
        erb :'cyclists/login'
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
