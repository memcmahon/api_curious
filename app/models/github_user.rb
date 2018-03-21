class GithubUser
  attr_reader :name,
              :avatar_url,
              :nickname,
              :bio,
              :location,
              :blog_url,
              :repositories_count,
              :stars_count,
              :followers_count,
              :following_count

  def initialize(attrs = {}, stars_count = 0)
    @name = attrs[:name]
    @avatar_url = attrs[:avatar_url]
    @nickname = attrs[:login]
    @bio = attrs[:bio]
    @location = attrs[:location]
    @blog_url = attrs[:blog]
    @repositories_count = attrs[:public_repos]
    @stars_count = stars_count
    @followers_count = attrs[:followers]
    @following_count = attrs[:following]
  end

  def self.create(token)
    new(GithubService.user_attrs(token), GithubService.stars_count(token))
  end

  def commit_feed(token)
    conn = Faraday.new("https://api.github.com/users/#{nickname}/events")
    response = conn.get do |req|
      req.params["access_token"] = token
    end
    commits = JSON.parse(response.body, symbolize_names: true).map do |event|
      if event[:type] == "PushEvent"
        event[:payload][:commits]
      end
    end
    binding.pry
  end
end
