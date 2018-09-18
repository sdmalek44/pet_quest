class OauthController < ApplicationController

  def create
    session[:lat] = params[:lat]
    session[:lon] = params[:lon]
    session[:last_path] = params[:last_path]
    redirect_to '/auth/google_oauth2'
  end

end
