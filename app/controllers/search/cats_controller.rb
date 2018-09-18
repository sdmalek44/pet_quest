class Search::CatsController < ApplicationController

  def index
    params[:latitude] = session[:lat] if session[:lat]
    params[:longitude] = session[:lon] if session[:lon]
    @presenter = CatSearchPresenter.new(current_user, search_params)
  end

  def show
    @presenter = CatPresenter.new(current_user, cat_params)
  end

  private

  def search_params
    params.permit(:breed, :age, :size, :sex, :latitude, :longitude)
  end

  def cat_params
    params.permit(:id, :name, :location, :size, :breed, :age, :sex)
  end
end
