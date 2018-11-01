class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id] != nil #already signed in!
      redirect '/users/:slug'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    if params[:user][:username].empty? || params[:user][:password].empty?
      redirect '/signup'
    else
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect '/users/:slug'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do

    redirect '/users/:slug'
  end

  get '/users/:slug' do

  end

end
