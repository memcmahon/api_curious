require 'rails_helper'

describe "user logs in and out" do
  scenario "using github oath" do
    stub_omniauth
    visit root_path
    click_link("Sign in with Github")
    expect(page).to have_link("Logout")

    expect(page).to have_xpath("/html/body/section/aside[1]/img")
    expect(page).to have_content("Megan McMahon")
    expect(page).to have_content("memcmahon")
    expect(page).to have_content("Backend Engineering Student at Turing School")
    expect(page).to have_content("Denver, CO")
    expect(page).to have_content("Repositories 39")
    expect(page).to have_content("Stars 0")
    expect(page).to have_content("Followers 1")
    expect(page).to have_content("Following 0")

    click_link("Logout")
    expect(page).to have_link("Sign in with Github")
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
        token: ENV["ACCESS_TOKEN"],
      }
    })
  end
end
