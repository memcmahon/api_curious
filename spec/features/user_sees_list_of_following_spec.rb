require 'rails_helper'

feature "User can see a list of all users they are following" do
  let(:user) { build(:user) }

  before (:each) do
    stub_omniauth

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    json_response = File.open("./spec/fixtures/user_following.json")

    stub_request(:get, "https://api.github.com/user/following?access_token=12345")
      .to_return(status: 200, body: json_response, headers: {})
  end

  describe "they visit user/following path" do
    it "they can see a list of their followers" do
      visit user_following_index_path(user)

      expect(page).to have_css("img[src='https://avatars2.githubusercontent.com/u/24374609?v=4']")
      expect(page).to have_css("img[src='https://avatars0.githubusercontent.com/u/26782839?v=4']")
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
