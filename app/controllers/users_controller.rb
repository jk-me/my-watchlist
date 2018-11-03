class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id] != nil
      redirect_current_user_page #already signed in!
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    if params[:user][:username].empty? || params[:user][:password].empty?
      redirect '/signup' #incomplete sign up form!
    else
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect_current_user_page
    end
  end

  get '/login' do
    if session[:user_id] != nil
      redirect_current_user_page  #already logged in!
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_current_user_page #wrong pw or username!
    else
      redirect '/login'
    end
  end

  get '/logout' do
    redirect_if_not_logged_in #not logged in!
    session.clear
    redirect '/'  #logged out!
  end

  get '/users/:id' do
    redirect_if_not_logged_in #not logged in!
    redirect_if_wrong_user #wrong user!

    @user = User.find(session[:user_id])
    erb :'users/show'
  end

end
