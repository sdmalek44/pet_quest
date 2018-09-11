class Search::CatsController < ApplicationController

  def index
  end

  def show
  end

  private

  def presenter
    @presenter ||= CatSearchPresenter.new(current_user, search_params)
  end

  def search_params
    params.permit(:breed, :age, :size, :sex, :id)
  end
end
