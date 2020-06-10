class SessionsController < ApplicationController
    
  get '/login' do
    erb :'sessions/new'
  end
    
  # post '/login' do
  #   user = User.find_by(email: params[:email])
  #   if user && user.authenticate(params[:password]) 
  #     session[:user_id] = user.id
  #     redirect "/users/#{user.id}" 
  #   else
  #     flash[:message] = "Something went wrong. Please try again."
  #     erb :'sessions/new'
  #   end
  # end

  post '/login' do
    #recieve the log in form, find user and log them in (create a session)
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:error] = "Could not find use: #{params[:email]}"
      redirect '/'
    elsif user.authenticate(params[:password]) # find a user & password is right
      # login & redirect sowmehere in site
      session[:user_id] = user.id
      # current_user
      redirect "/users/#{user.id}" 
    else
      flash[:error] = "Wrong Password for user: #{params[:email]}"
      redirect '/'
    end
  end
    
  get '/logout' do
    session.clear
    flash[:message] = "You have been logged out."
    redirect '/'
  end
  
end