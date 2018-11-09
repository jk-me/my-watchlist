class ShowsController < ApplicationController

  get '/shows/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @user = User.find(session[:user_id])
    erb :'shows/new'
  end

  post '/shows' do
    if params[:show][:name].empty?
      redirect '/shows/new?error=Submit error, name required!' #incomplete submission! must have name!
    else
      s = Show.create(params[:show])
      s.update(user_id: session[:user_id])
      redirect_current_user_page
    end
  end

  get '/shows/:id' do
    redirect_if_not_logged_in
    @show = Show.find(params[:id])
    redirect_wrong_user if current_user.id != @show.user_id
    erb :'shows/show'
  end

  get '/shows/:id/edit' do
    redirect_if_not_logged_in
    @show = Show.find(params[:id])
    redirect_wrong_user if current_user.id != @show.user_id
    erb :'shows/edit'
  end

  patch '/shows/:id' do
    redirect "/users/#{session[:user_id]}?error=Submit error, name required!" if params[:show][:name].empty?  #incomplete submission! must have name!
    s = Show.find(params[:id])
    redirect_wrong_user if current_user.id != s.user_id
    s.update(params[:show])
    redirect_current_user_page
  end

  delete '/shows/:id' do
    s = Show.find(params[:id])
    redirect_wrong_user if current_user.id != s.user_id
    s.delete
    redirect_current_user_page

  end
end
