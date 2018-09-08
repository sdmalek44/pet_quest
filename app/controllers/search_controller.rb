class SearchController < ApplicationController
  def index

  end

  private

  def presenter
    @presenter ||= SearchPresenter.new(current_user)
  end
end
