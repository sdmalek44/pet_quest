class SessionsController < ApplicationController
  def index
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth[:provider], auth[:uid]) || User.create_with_omniauth(auth)
    user.update(token: auth["credentials"]["token"])
    session[:user_id] = user.id
    path = session[:last_path] if session[:last_path]
    session[:last_path] = nil
    redirect_to path if path
    redirect_to root_path unless path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
