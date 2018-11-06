require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/' do
    @error_message = params[:error]
    erb :index
  end

  helpers do
    def redirect_if_not_logged_in
      if session[:user_id] == nil
        redirect "/?error=You have to be logged in to do that"
      end
    end

    def redirect_wrong_user
      redirect "/users/#{session[:user_id]}?error=You may not access another user's information"
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_current_user_page
      redirect "/users/#{session[:user_id]}"
    end

  end

end
