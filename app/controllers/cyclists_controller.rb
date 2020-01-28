require 'bcrypt'
require 'sinatra'

class CyclistsController < ApplicationController
  get '/cyclists/:slug' do
      @user = Cyclist.find_by_slug(params[:slug])
      erb :'/cyclists/show'
    end

    get '/signup' do
      if !logged_in?
        erb :'/cyclists/new', locals: {message: "Please sign up before you sign in"}
      else
        redirect to '/rides'
      end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
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
        redirect to :'/rides'
      end
    end

    post '/login' do
      user = Cyclist.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to "/rides"
      else
        flash[:message] = "Your Username or Password is Incorrect."
        redirect to '/signup'
      end
    end

    get '/logout' do
      if logged_in?
        session.destroy
        redirect to '/login'
      else
        redirect to '/rides'
      end
    end
  end
