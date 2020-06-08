class SessionsController < ApplicationController
    
  get '/login' do
    erb :'sessions/new'
  end
    
  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) 
      session[:user_id] = user.id
      redirect "/users/#{user.id}" 
    else
      flash[:error] = "Invalid credentials! Please sign up, or try again."
      erb :'sessions/new'
    end
  end
    
  get '/logout' do
    session.clear
    flash[:error] = "You have been logged out."
    redirect '/'
  end
  
end