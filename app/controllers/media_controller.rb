class MediaController < ApplicationController

  get '/media/new' do
    @user = User.find(session[:user_id])
    erb 'media/new'
  end

  post '/media' do

  end
end
