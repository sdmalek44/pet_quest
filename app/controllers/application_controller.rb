class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :presenter

  def current_user
    @user ||= User.find_by(id: session[:user_id]) || NullUser.new
  end

  def presenter
    @presenter ||= HomePresenter.new(current_user)
  end
end
