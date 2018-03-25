class GithubService
  def self.conn(url)
    Faraday.new("https://api.github.com#{url}")
  end

  def self.parse(response_body)
    JSON.parse(response_body, symbolize_names: true)
  end

  def self.user_attrs(token)
    response = conn("/user").get do |req|
      req.params["access_token"] = token
    end
    parse(response.body)
  end

  def self.stars_count(token)
    response = conn("/user/starred").get do |req|
      req.params["access_token"] = token
    end
    parse(response.body).count
  end

  def self.user_commits(token, username)
    response = conn("/search/commits").get do |req|
      req.headers["Accept"] = "application/vnd.github.cloak-preview+json"
      req.params["access_token"] = token
      req.params["q"] = "author:#{username} committer-date:>#{DateTime.now.prev_day(7).strftime("%Y-%m-%d")}"
    end
    parse(response.body)
  end

  def self.following(token)
    response = conn("/user/following").get do |req|
      req.params["access_token"] = token
    end
    parse(response.body)
  end

  def self.event_pages(username)
    Faraday.get("http://api.github.com/users/#{username}/events").headers
  end

  def self.events(username, n)
    response = conn("/#{username}/events?page=#{n}").get
    parse(response.body)
  end
end
