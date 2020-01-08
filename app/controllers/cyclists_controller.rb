class CyclistsController < ApplicationController
 get '/signup' do
    if logged_in?
      redirect to "/cyclists/#{current_user.id}"
    else
      erb :'/cyclists/create_cyclist'
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/cyclists/#{current_user.id}"
    else
      erb :'/cyclists/login_cyclist'
    end
  end

  post '/login' do
    @cyclist = Cyclist.find_by(username: params[:username], password: params[:password])
      if !@cyclist.nil?
        session[:user_id] = @cyclist.id
       redirect to '/'
      else
       redirect to '/login'
      end
    end

    post '/signup' do
     @cyclist = Cyclist.new(username: params[:username], password: params[:password], email: params[:email], bio: params[:bio])
    if @cyclist.save
      session[:user_id] = @cyclist.id
      redirect to "/cyclists/#{@cyclist.id}"
    else
      redirect to '/signup'
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

  get '/logout' do
   if logged_in?
     session.clear
     redirect to '/'
   else
     redirect to '/'
   end
 end


  delete "/cyclists/:id/delete" do
   @cyclist = Cyclist.find_by_id(params[:id])
   if logged_in? && @cyclist == current_user
     @cyclist.posts.each do |post|
       post.delete
     end
     @cyclist.rides.each do |ride|
       ride.delete
     end
     @cyclist.delete
     session/clear
     redirect to '/'
   else
    redirect to '/login'
    end
  end
end
