require 'rails_helper'

describe "user logs in and out" do
  scenario "using github oath" do
    user_json_response = File.open("./spec/fixtures/user.json")
    user_stars_json_response = File.open("./spec/fixtures/user_stars.json")

    stub_request(:get, "https://api.github.com/user?access_token=12345").
      to_return(status: 200, body: user_json_response, headers: {})

    stub_request(:get, "https://api.github.com/user/starred?access_token=12345").
      to_return(status: 200, body: user_stars_json_response, headers: {})

    user_commits_json_response = File.open("./spec/fixtures/user_commits.json")

    stub_request(:get, "https://api.github.com/search/commits?access_token=12345&q=author:memcmahon committer-date:>#{DateTime.now.prev_day(7).strftime("%Y-%m-%d")}")
      .with(headers: {'Accept'=>'application/vnd.github.cloak-preview+json'})
      .to_return(status: 200, body: user_commits_json_response, headers: {})

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
    expect(page).to have_content("Stars 1")
    expect(page).to have_content("Followers 1")
    expect(page).to have_content("Following 0")

    click_link("Logout")
    expect(page).to have_link("Sign in with Github")
  end

  scenario "they see a list of their recent commits" do
    user_json_response = File.open("./spec/fixtures/user.json")
    user_stars_json_response = File.open("./spec/fixtures/user_stars.json")

    stub_request(:get, "https://api.github.com/user?access_token=12345")
      .to_return(status: 200, body: user_json_response, headers: {})

    stub_request(:get, "https://api.github.com/user/starred?access_token=12345")
      .to_return(status: 200, body: user_stars_json_response, headers: {})

    user_commits_json_response = File.open("./spec/fixtures/user_commits.json")

    stub_request(:get, "https://api.github.com/search/commits?access_token=12345&q=author:memcmahon committer-date:>#{DateTime.now.prev_day(7).strftime("%Y-%m-%d")}")
      .with(headers: {'Accept'=>'application/vnd.github.cloak-preview+json'})
      .to_return(status: 200, body: user_commits_json_response, headers: {})

    stub_omniauth

    visit root_path

    click_link("Sign in with Github")

    expect(page).to have_content("Recent Commits")
    within ".commits" do
      expect(page).to have_content("Adds model spec for user#from_omniauth")
      expect(page).to have_content("2018-03-19 14:17:43")
      expect(page).to have_content("memcmahon/api_curious")
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
