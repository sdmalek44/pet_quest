class HomePresenter
  def initialize(user)
    @user = user
  end

  def current_navbar
    return 'log_out_nav.html.erb' if user.logged_in?
    'log_in_nav.html.erb'
  end

  def current_message
    "Welcome, #{user.first_name}" unless user.first_name.nil?
  end

  private

  attr_reader :user
end
