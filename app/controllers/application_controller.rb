require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'my_secret'
    register Sinatra::Flash
  end

  get '/' do
    if is_logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
  end

  helpers do
    def is_logged_in?
     session.has_key?(:user_id)
    end

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if is_logged_in?       
    end

    def redirect_if_not_logged_in
      if !is_logged_in?
        flash[:errors] = "You must be logged in to continue."
        redirect '/'
      end
    end

  end

end
