require 'date'

class GithubService
  def self.user_attrs(token)
    conn = Faraday.new("https://api.github.com/user")
    response = conn.get do |req|
      req.params["access_token"] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.stars_count(token)
    conn = Faraday.new("https://api.github.com/user/starred")
    response = conn.get do |req|
      req.params["access_token"] = token
    end
    JSON.parse(response.body, symbolize_names: true).count
  end

  def self.user_commits(token, username)
    conn = Faraday.new("https://api.github.com/search/commits")
    response = conn.get do |req|
      req.headers["Accept"] = "application/vnd.github.cloak-preview+json"
      req.params["access_token"] = token
      req.params["q"] = "author:#{username} committer-date:>#{DateTime.now.prev_day(7).strftime("%Y-%m-%d")}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.following(token)
    conn = Faraday.new("https://api.github.com/user/following")
    response = conn.get do |req|
      req.params["access_token"] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
