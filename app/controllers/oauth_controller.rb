class OauthController < ApplicationController

  def create
    session[:last_path] = params[:last_path]
    redirect_to '/auth/google_oauth2'
  end

end
