require 'bcrypt'
require 'sinatra'

class CyclistsController < ApplicationController

  get '/signup' do
        if !logged_in?
           erb :'/cyclists/new'
        else
          redirect to '/rides'
        end
      end

      get '/login' do
         if logged_in?
           redirect to '/rides'
         else
          erb :'/cyclists/login'
        end
      end

      post '/login' do
        @user = Cyclist.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/rides'
        else
            redirect '/signup'
        end
      end

      post '/signup' do
         if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
         else
              @user = Cyclist.create(:username => params[:username], :email => params[:email],  :password => params[:password])
              @user.save
              session[:user_id] = @user.id
             redirect to '/rides'
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
