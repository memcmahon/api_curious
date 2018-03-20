class UsersController < ApplicationController
  def show
    conn = Faraday.new("https://api.github.com/user")
    response = conn.get do |req|
      req.params["client_id"] = ENV["CLIENT_ID"]
      req.params["client_secret"] = ENV["CLIENT_SECRET"]
      req.params["access_token"] = current_user.token
    end
    attrs = JSON.parse(response.body, symbolize_names: true)
    @github_user = GithubUser.new(attrs)
  end
end
