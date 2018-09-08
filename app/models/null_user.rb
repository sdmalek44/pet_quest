class NullUser
  attr_reader :provider,
              :uid,
              :first_name,
              :last_name,
              :email,
              :token

  def logged_in?
    nil
  end
end
