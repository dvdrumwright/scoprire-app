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
    if  @cyclist = Cyclist.find_by(username: params[:username])
        @cyclist.save
        session[:user_id] = @cyclist.id
        redirect to "/cyclists/#{current_user.id}"
     else
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
       cyclist = Cyclist.find_by(username: params[:username])

     if cyclist && cyclist.authenticate(params[:password])
        session[:user_id] = cyclist.id
        redirect to "/cyclists/#{current_user.id}"
      else
        flash[:message] = "Your username or password were not correct. Please try again."
        erb :'cyclists/login'
      end
    end

    get '/cyclists/:id' do
      if Cyclist.logged_in?(session) && @Cyclist = Cyclist.current_user(session)
          erb :'/cyclists/show'
        else
      redirect to '/'
      end
    end

    get '/logout' do
      if logged_in?
        session.clear
        flash[:message] = "You have been logged out of your account."
        redirect to '/cyclists/login'
    end
  end
end
