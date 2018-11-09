class MoviesController < ApplicationController

  get '/movies/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @user = User.find(session[:user_id])
    erb :'movies/new'
  end

  post '/movies' do
    if params[:movie][:name].empty?
      redirect '/movies/new?error=Submit error, name required!'
    else
      m = Movie.create(params[:movie])
      m.user_id = session[:user_id]
      m.save
      redirect_current_user_page
    end
  end

  get '/movies/:id' do
    redirect_if_not_logged_in
    @movie = Movie.find(params[:id])
    redirect_wrong_user if current_user.id != @movie.user_id
    erb :'movies/show'
  end

  get '/movies/:id/edit' do
    redirect_if_not_logged_in
    @movie = Movie.find(params[:id])
    redirect_wrong_user if current_user.id != @movie.user_id
    erb :'movies/edit'
  end

  patch '/movies/:id' do
    redirect "/users/#{session[:user_id]}?error=Submit error, name required!" if params[:movie][:name].empty?  #incomplete submission! must have movie name!
    m = Movie.find(params[:id])
    redirect_wrong_user if current_user.id != m.user_id
    m.update(params[:movie])
    redirect_current_user_page
  end

  delete '/movies/:id' do
    m = Movie.find(params[:id])
    redirect_wrong_user if current_user.id != m.user_id
    m.delete
    redirect_current_user_page

  end

end
