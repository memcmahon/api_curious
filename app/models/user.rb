class User < ApplicationRecord

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |user|
      user.uid = auth_info[:uid]
      user.nickname = auth_info[:info][:nickname]
      user.name = auth_info[:info][:name]
      user.email = auth_info[:info][:email]
      user.token = auth_info[:credentials][:token]
    end
  end
end
