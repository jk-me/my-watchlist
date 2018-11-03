class MoviesController < ApplicationController

  get '/movies/new' do
    redirect_if_not_logged_in
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
    redirect_if_not_logged_in
    #correct user check
    @movie = Movie.find(params[:id])
    erb :'movies/edit'
  end

  patch '/movies/:id' do
    m = Movie.find(params[:id])
    m.update(params[:movie])
    redirect "/users/#{session[:user_id]}"
  end

  delete '/movies/:id' do
    m = Movie.find(params[:id])
    m.delete
    redirect "/users/#{session[:user_id]}"

  end

end
