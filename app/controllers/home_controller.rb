class HomeController < ApplicationController
  helper_method :presenter

  def index
    @presenter = HomePresenter.new(current_user)
  end

end
