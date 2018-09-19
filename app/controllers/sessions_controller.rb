class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth[:provider], auth[:uid]) || User.create_with_omniauth(auth)
    user.update(zip: Geocoder.search([session[:lat], session[:lon]]).first.data['address']['postcode']) if user.zip.nil? && session['lat'].present?
    user.update(token: auth["credentials"]["token"])
    session[:user_id] = user.id
    last_path = session[:last_path] if session[:last_path]
    session[:last_path] = nil

    redirect_to root_path unless last_path
    redirect_to last_path if last_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
