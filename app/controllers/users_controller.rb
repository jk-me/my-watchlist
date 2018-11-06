class UsersController < ApplicationController

  get '/signup' do
    @error_message = params[:error]
    if session[:user_id] != nil
      redirect_current_user_page #already signed in!
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    if params[:user][:username].empty? || params[:user][:password].empty? || (User.find_by(username: params[:user][:username])!=nil)
      redirect '/signup?error=Incomplete sign up form, or username has already been taken!'
    else
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect_current_user_page
    end
  end

  get '/login' do
    @error_message = params[:error]
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
      redirect_current_user_page
    else
      redirect '/login?error=Incorrect username or password!'
    end
  end

  get '/logout' do
    redirect_if_not_logged_in #not logged in!
    session.clear
    redirect '/'  #logged out!
  end

  get '/users/:id' do
    @error_message = params[:error]
    redirect_if_not_logged_in #not logged in!
    redirect_wrong_user if session[:user_id] != params[:id].to_i #wrong user!

    @user = User.find(session[:user_id])
    erb :'users/show'
  end

end
