require 'bcrypt'
require 'sinatra'

class CyclistsController < ApplicationController

   get '/signup' do
      if logged_in?
         redirect to "/cyclists/#{current_user.id}"
      else
        erb :'/cyclists/new'
      end
    end

    post '/signup' do
       if params[:username] == "" || params[:email] == "" || params[:password] == ""
          flash[:sign_up] = "Please make sure to fill out all the fields"
          redirect to '/signup'
        end

        if !Cyclist.new(:username => params[:username], :password => params[:password])
           redirect to '/signup'
        elsif !Cyclist.new(:email => params[:email], :password => params[:password])
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
         if logged_in?
           redirect to "/cyclists/#{current_user.id}"
         else
          erb :'/cyclists/login'
        end
      end

    post '/login' do
      @user = Cyclist.find_by(:username => params[:username], :pasword => params[:password])

      if !@user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to '/rides'
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
