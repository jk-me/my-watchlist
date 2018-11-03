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
      redirect_current_user_page
    end
  end

  get '/movies/:id/edit' do
    redirect_if_not_logged_in
    @movie = Movie.find(params[:id])
    redirect_current_user_page if current_user.id != @movie.user_id
    erb :'movies/edit'
  end

  patch '/movies/:id' do
    redirect_current_user_page if params[:movie][:name].empty?  #incomplete submission! must have movie name!
    m = Movie.find(params[:id])
    m.update(params[:movie])
    redirect_current_user_page
  end

  delete '/movies/:id' do
    m = Movie.find(params[:id])
    m.delete
    redirect_current_user_page

  end

end
