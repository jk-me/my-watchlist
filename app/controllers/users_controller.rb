class UsersController < ApplicationController

  get '/signup' do
<<<<<<< HEAD
    if session[:user_id] != nil
      redirect '/users/:slug' #already signed in!
=======
    if session[:user_id] != nil #already signed in!
      redirect '/users/:slug'
>>>>>>> 558ad12ea4ae4f151ada20f20cd431edaf3298bf
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    if params[:user][:username].empty? || params[:user][:password].empty?
<<<<<<< HEAD
      redirect '/signup' #incomplete sign up form!
=======
      redirect '/signup'
>>>>>>> 558ad12ea4ae4f151ada20f20cd431edaf3298bf
    else
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect '/users/:slug'
    end
  end

  get '/login' do
    if session[:user_id] != nil
      redirect '/users/:slug'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/users/:slug'
    else
      redirect '/login'
    end
  end

<<<<<<< HEAD
=======
  post '/login' do

    redirect '/users/:slug'
  end

>>>>>>> 558ad12ea4ae4f151ada20f20cd431edaf3298bf
  get '/users/:slug' do

  end

end
