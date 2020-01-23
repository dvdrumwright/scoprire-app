require 'bcrypt'
require 'sinatra'

class CyclistsController < ApplicationController


#sign up============================================================
get '/signup' do
 if logged_in?
    flash[:message] = "You are logged In. Here are Grouppetto's near you."
    # erb :'/cyclists/create_cyclist'
    redirect to "/rides"
    # redirect to "/cyclists/#{current_user.id}"
  else
    logged_in?
    flash[:message] = "Don't Have an account !"
    erb :'/cyclists/create_cyclist'
  end
end

post '/signup' do
  if logged_in?
    flash[:message] = "You are logged in. Here are Grouppeto's near you."
    redirect to "/rides"
  elsif params[:username] == "" || params[:password] == ""
    flash[:message] = "In order to sign up, you must have username and password. Please try again."
     redirect to '/signup'
  else
     @cyclist = Cyclist.create(username: params[:username], password: params[:password])
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
    #  erb :'/edit_cyclist'
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
  if logged_in?
  @cyclist = Cyclist.find_by_id(params[:id])
  if @cyclist.logged_in? == current_user
     flash[:message] = "Looks like you weren't logged in yet. Please log in below."
     erb :'/cyclists/edit_cyclist'
  else
     redirect to '/login'
   end
end

patch "/cyclists/:id" do
  if params[:username] == "" || params[:email] == "" || params[:password] == ""
  flash[:message] = "Oops!  Please try again."
  redirect to "/cyclists/#{params[:id]/edit_cyclist}"
else
  @cyclist = Cyclist.find_by_id(params[:id])
  @cyclist.username = params[:username]
  @cyclist.email = params[:email]
  @cyclist.password = params[:password]
  @cyclist.bio = params[:bio]
  @cyclist.save
  flash[:message]= "Your information has been updated"
  redirect to "/cyclists/#{@cyclist.id}"
  end
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
