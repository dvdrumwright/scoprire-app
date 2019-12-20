class RidesController < ApplicationController

  # GET: /rides
  get "/rides" do
    erb :"/rides/index.html"
  end

  # GET: /rides/new
  get "/rides/new" do
    erb :"/rides/new.html"
  end

  # POST: /rides
  post "/rides" do
    redirect "/rides"
  end

  # GET: /rides/5
  get "/rides/:id" do
    erb :"/rides/show.html"
  end

  # GET: /rides/5/edit
  get "/rides/:id/edit" do
    erb :"/rides/edit.html"
  end

  # PATCH: /rides/5
  patch "/rides/:id" do
    redirect "/rides/:id"
  end

  # DELETE: /rides/5/delete
  delete "/rides/:id/delete" do
    redirect "/rides"
  end
end
