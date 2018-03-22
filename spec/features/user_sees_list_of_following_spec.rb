require 'rails_helper'

feature "User can see a list of all users they are following" do
  let(:user) { build(:user) }
  
  before (:each) do
    stub_omniauth

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe "they visit user/following path" do
    it "they can see a list of their followers" do
      visit user_following_index_path(user)

      expect(page).to have_content("corneliusellen")
      expect(page).to have_content("annaroyer")
    end
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "123456",
      info: {
        name: "Megan McMahon",
        email: "meganmcmahon@gmail.com",
        nickname: "memcmahon"
      },
      credentials: {
        token: 12345,
      }
    })
  end
end
