require 'rails_helper'

RSpec.describe User, type: :model do
  it "finds or creates itself from an oauth hash" do
    auth = {
      provider: "github",
      uid: "123456",
      info: {
        nickname: "memcmahon",
        name: "Megan McMahon",
        email: "meganmcmahon88@gmail.com"
      },
      credentials: {
        token: "1234abcd"
      }
    }

    User.from_omniauth(auth)
    user = User.first

    expect(user.uid).to eq("123456")
    expect(user.token).to eq("1234abcd")
  end
end
