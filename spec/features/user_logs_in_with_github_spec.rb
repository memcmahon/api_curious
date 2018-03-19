require 'rails_helper'

describe "user logs in" do
  scenario "using github oath" do
    stub_omniauth
    visit root_path
    click_link("Sign in with Github")
    expect(page).to have_content("Megan McMahon")
    expect(page).to have_link("Logout")
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
        token: "acd123",
      }
    })
  end
end
