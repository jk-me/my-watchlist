require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/' do
    erb :index
  end

  helpers do
    def redirect_if_not_logged_in
      if session[:user_id] == nil
        redirect "/"
      end
    end

    def redirect_if_wrong_user
      if session[:user_id] != params[:id].to_i
        redirect "/users/#{session[:user_id]}"
      end
    end
  end

end
