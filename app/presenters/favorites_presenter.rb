class FavoritesPresenter < BasePresenter

  def initialize(user)
    super(user)
  end

  def favorites
    user.favorites
  end

end
