class RidesController < ApplicationController
  get '/rides' do
    if logged_in?
      erb :'/rides'
    else
        flash[:message] = "Please login first"
        redirect to '/rides'
      end
  end

end
