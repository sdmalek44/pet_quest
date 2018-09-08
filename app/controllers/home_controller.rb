class HomeController < ApplicationController
  helper_method :presenter

  def index
    
  end

  private

  def presenter
    @presenter ||= HomePresenter.new(current_user)
  end
end
