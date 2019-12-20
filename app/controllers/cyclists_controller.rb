class CyclistsController < ApplicationController

  # GET: /cyclists
  get "/cyclists" do
    erb :"/cyclists/index.html"
  end

  # GET: /cyclists/new
  get "/cyclists/new" do
    erb :"/cyclists/new.html"
  end

  # POST: /cyclists
  post "/cyclists" do
    redirect "/cyclists"
  end

  # GET: /cyclists/5
  get "/cyclists/:id" do
    erb :"/cyclists/show.html"
  end

  # GET: /cyclists/5/edit
  get "/cyclists/:id/edit" do
    erb :"/cyclists/edit.html"
  end

  # PATCH: /cyclists/5
  patch "/cyclists/:id" do
    redirect "/cyclists/:id"
  end

  # DELETE: /cyclists/5/delete
  delete "/cyclists/:id/delete" do
    redirect "/cyclists"
  end
end
