class UsersController < ApplicationController
  
  get '/signup' do
    erb :'users/signup'
  end

  post '/users' do
    if params[:email] != "" && params[:password] != "" && params[:name] != ""
      @user = User.new(email: params[:email], 
                       password: params[:password],
                       name: params[:name])
      if @user.save
        session[:user_id] = @user.id
        flash[:message] = "Welcome, #{@user.name}. You have successfully created an account."
        redirect "/users/#{@user.id}"
      else
        flash[:error] = "User exists. "
        redirect '/'
      end  
    else
      flash[:error] = "You must input your name, an email and a password to continue."
      redirect '/signup'
    end
  end

  get '/users/:id' do
    redirect '/' if !(is_logged_in?)
    @user = current_user
    @pets = @user.pets
    erb :'/users/show'
  end
end