class SessionsController < ApplicationController
    
  get '/login' do
    erb :'sessions/new'
  end
    
  post '/login' do
        #recieve the log in form, find user and log them in (create a session)
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) # find a user & password is right
          # login & redirect sowmehere in site
    session[:user_id] = user.id
    redirect "/users/#{user.id}" 
        # redirect "/users/#{user.id}"
    else
      erb :'sessions/new'
    end
  end
    
  get '/logout' do
    session.clear
    flash[:error] = "You have been logged out."
    redirect '/'
  end
  
end