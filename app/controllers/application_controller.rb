require './config/environment'
require 'sinatra/base'
require 'rack-flash'
require 'json'
require 'open-uri'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    enable :sessions
    set :sessions_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end


  helpers do

      def logged_in?
        !!current_user
      end

      def current_user
        @current_user ||= Cyclist.find_by(id: session[:user_id]) if session[:user_id]
      end

    end
end
