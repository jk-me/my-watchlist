class MoviesController < ApplicationController

  get '/movies/new' do
    @user = User.find(session[:user_id])
    erb :'movies/new'
  end

  post '/movies' do
    if params[:movie][:name].empty?
      redirect '/movies/new' #incomplete submission! must have movie name!
    else
      m = Movie.create(params[:movie])
      m.user_id = session[:user_id]
      m.save
      redirect "/users/#{session[:user_id]}"
    end
  end

  get '/movies/:id/edit' do
    @movie = Movie.find(params[:id])
    erb :'movies/edit'
  end
end
