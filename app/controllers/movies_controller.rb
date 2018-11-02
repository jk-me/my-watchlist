class MoviesController < ApplicationController

  get '/movies/new' do
    @user = User.find(session[:user_id])
    erb :'movies/new'
  end

  post '/movie' do
    if params[:movie][:name].empty?
      redirect '/movie/new' #incomplete submission! must have movie name!
    else
      Movie.create(params[:movie], user_id: session[:user_id])
      redirect "/users/#{session[:user_id]}"
    end
  end
end
