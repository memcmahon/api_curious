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
    JSON.parse(response.body).count
  end
end
