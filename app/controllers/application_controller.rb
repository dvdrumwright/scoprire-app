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
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end

    end


    def fields_empty?(params)
    error = false
    params.values.each do |input|
      if input.empty?
        flash[:message] = "Please complete all fields."
        error = true
      end
    end
    error
  end 













end
