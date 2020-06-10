class SessionsController < ApplicationController
    
  get '/login' do
    erb :'sessions/new'
  end
    
  post '/login' do
    
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:error] = "Could not find use: #{params[:email]}"
      redirect '/'
    elsif user.authenticate(params[:password]) 
      session[:user_id] = user.id  
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