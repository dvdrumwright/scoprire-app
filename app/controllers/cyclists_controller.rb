require 'bcrypt'
require 'sinatra'

class CyclistsController < ApplicationController


#sign up============================================================
get '/signup' do
 if logged_in?
    flash[:message] = "You are logged In. Here are Grouppetto's near you."
    redirect to "/rides"
    # redirect to "/cyclists/#{current_user.id}"
  else
    logged_in?
    flash[:message] = "Don't Have an account !"
    erb :'/cyclists/create_cyclist'

  end
end

post '/signup' do
  if params[:username] == "" || params[:email] == "" || params[:password] == ""
     redirect to '/cyclists/create_cyclist'
  else
     @cyclist = Cyclist.new(:username => params[:username], :email => params[:email])
     @cyclist.save
     session[:user_id]= @cyclist.id
     redirect to '/'
  end
end

#login=============================================================
get '/login' do
  if logged_in?
    flash[:message] = "Your logged in."
    redirect '/rides'
    #  redirect to "/cyclists/#{current_user.id}"
  else
     erb :'/cyclists/login_cyclist'
  end
end

post '/login' do
   cyclist = Cyclist.find { |u| u.username == params[:username] }
  if cyclist && cyclist.authenticate(params[:password])
     session[:user_id] = cyclist.id
     redirect to '/rides'
  else
     flash[:message] = "Your username or password were not correct. Please try again."
     redirect to '/login'
  end
end


#update------------------------------------------------
get "/cyclists/:id/edit" do
  @cyclist = Cyclist.find_by_id(params[:id])
  if logged_in? && @cyclist  == current_user
     erb :'/cyclists/edit_cyclist'
  else
     redirect to '/login'
   end
end


patch "/cyclists/:id" do
  @cyclist = Cyclist.find_by_id(params[:id])
  @cyclist.username = params[:username]
  @cyclist.email = params[:email]
  @cyclist.password = params[:password]
  @cyclist.bio = params[:bio]
  if logged_in? && @cyclist == current_user && @cyclist.valid?
     @cyclist.save
      redirect to "/cyclists/#{@cyclist.id}"
  else
      redirect to '/login'
  end
end

get "/cyclists/:id" do
 @cyclist = Cyclist.find_by_id(params[:id])
 if logged_in? && @cyclist  == current_user
     erb :'/cyclists/show_cyclist'
  else
    redirect to '/login'
  end
end


#delete======================================================
delete "/cyclists/:id/delete" do
   @cyclist = Cyclist.find_by_id(params[:id])
    if logged_in? && @cyclist == current_user
   @cyclist.posts.each do |post| post.delete
     end
   @cyclist.rides.each do |ride| ride.delete
     end
    @cyclist.delete
     session/clear
     redirect to '/'
   else
    redirect to '/login'
    end
  end

#user-log-out===================================================
get '/logout' do
 if logged_in?
    session.clear
    flash[:message] = "You have been logged out of your account."
    redirect to '/login'
  else
    redirect to '/'
    end
  end
end
