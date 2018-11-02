class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id] != nil
      redirect "/users/#{session[:user_id]}" #already signed in!
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
      redirect "/users/#{user.id}"
    end
  end

  get '/login' do
    if session[:user_id] != nil
      redirect "/users/#{session[:user_id]}"  #already logged in!
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}" #wrong password or username!
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if session[:user_id] == nil
      redirect '/'  #not logged in!
    else
      session.clear
      redirect '/'  #logged out!
    end
  end

  get '/users/:id' do
    if session[:user_id] == nil
      redirect '/'  #not logged in!
    elsif session[:user_id] != params[:id]
      redirect "/users/#{session[:user_id]}" #does not let logged in user access another user's page
    else
      erb :'users/show'
  end

end
