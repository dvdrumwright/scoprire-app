require './config/environment'
require 'sinatra/base'
require 'rack-flash'
require 'json'
require 'open-uri'
require 'pry'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    enable :sessions
    set :sessions_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :root
  end


  get '/home' do
        authorize
        erb :home
    end

    get '/logout' do
        session.clear
        redirect '/'
    end



  helpers do

      def logged_in?
          !!Cyclist.find_by(id: session[:user_id])
      end

      def current_user
       user = Cyclist.find_by(id: session[:user_id]) if session[:user_id]
      end

      def authenticate(username, password)
            user = Cyclist.find_by(username: username)
            session[:user_id] = user.id
            user
       end

       def authorize
           current_user
       end

       def own_run?(ride)
             current_user == ride.user
         end

         def login_error_messages(errors)
            if errors
                erb :'Cyclists/_errors', locals: {errors: errors}
            end
        end


    end
end
