class User < ApplicationRecord

  def self.from_omniauth(auth_info)
    if where(uid: auth_info[:uid])
      where(uid: auth_info[:uid]).update(token: auth_info[:credentials][:token])
    else
      create(uid: auth_info[:uid], token: auth_info[:credentials][:token])
    end
  end
end
