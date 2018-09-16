class Default::BaseController < ApplicationController

  private

  def verify_user
    render file: "/public/404", layout: false unless current_user.logged_in?
  end

  def correct_user
    render file: "/public/404", layout: false unless current_user.id.to_s == params[:id] && current_user.logged_in?
  end
end
