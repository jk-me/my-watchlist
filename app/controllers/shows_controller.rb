class ShowsController < ApplicationController

  get '/shows/new' do
    redirect_if_not_logged_in
    @user = User.find(session[:user_id])
    erb :'shows/new'
  end

  post '/shows' do
    if params[:show][:name].empty?
      redirect '/shows/new' #incomplete submission! must have name!
    else
      s = Show.create(params[:show])
      s.update(user_id: session[:user_id])
      redirect_current_user_page
    end
  end

  get '/shows/:id' do
    redirect_if_not_logged_in
    @show = Show.find(params[:id])
    redirect_current_user_page if current_user.id != @show.user_id
    erb :'shows/show'
  end

  get '/shows/:id/edit' do
    redirect_if_not_logged_in
    @show = Show.find(params[:id])
    redirect_current_user_page if current_user.id != @show.user_id
    erb :'shows/edit'
  end

  patch '/shows/:id' do
    redirect_current_user_page if params[:show][:name].empty?  #incomplete submission! must have name!
    s = Show.find(params[:id])
    s.update(params[:show])
    redirect_current_user_page
  end

  delete '/shows/:id' do
    s = Show.find(params[:id])
    s.delete
    redirect_current_user_page

  end
end
