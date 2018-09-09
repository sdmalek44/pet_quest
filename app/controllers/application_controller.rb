class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_user
  helper_method :presenter

  def current_user
    @user ||= User.find_by(id: session[:user_id]) || NullUser.new
  end

end
