class ShowsController < ApplicationController

  get '/shows/new' do
    @user = User.find(session[:user_id])
    erb :'shows/new'
  end

  post '/shows' do
    if params[:show][:name].empty?
      redirect '/shows/new' #incomplete submission! must have movie name!
    else
      s = Show.create(params[:show])
      s.update(user_id: session[:user_id])
      redirect "/users/#{session[:user_id]}"
    end
  end
end
