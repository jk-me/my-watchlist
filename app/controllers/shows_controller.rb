class ShowsController < ApplicationController

  get '/shows/new' do
    @user = User.find(session[:user_id])
    erb :'shows/new'
  end

  post '/shows' do
    if params[:show][:name].empty?
      redirect '/shows/new' #incomplete submission! must have name!
    else
      s = Show.create(params[:show])
      s.update(user_id: session[:user_id])
      redirect "/users/#{session[:user_id]}"
    end
  end

  get '/shows/:id/edit' do
    redirect_if_not_logged_in
    #correct user check
    @show = Show.find(params[:id])
    erb :'shows/edit'
  end

  patch '/shows/:id' do
    s = Show.find(params[:id])
    s.update(params[:show])
    redirect "/users/#{session[:user_id]}"
  end

  delete '/shows/:id' do
    s = Show.find(params[:id])
    s.delete
    redirect "/users/#{session[:user_id]}"

  end
end
