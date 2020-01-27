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

   def current_user(session_hash)
     Cyclist.find(session_hash[:user_id])
   end

   def logged_in?(session_hash)
     !!session_hash[:user_id]
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
