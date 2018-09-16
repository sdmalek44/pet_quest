class User < ApplicationRecord
  has_many :favorites
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.first_name = auth[:info][:first_name]
      user.last_name = auth[:info][:first_name]
      user.email = auth[:info][:email]
      user.token = auth[:credentials][:token]
    end
  end

  def logged_in?
    true
  end
end
