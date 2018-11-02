class MoviesController < ApplicationController

  get '/movies/new' do
    @user = User.find(session[:user_id])
    erb :'movies/new'
  end

  post '/movie' do
    if params[:show][:name].empty? and params[:movie][:name].empty?
      redirect '/movie/new' #incomplete submission! must have show or movie name!
    else
      #Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect '/tweets'
    end
  end
end
