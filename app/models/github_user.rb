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

  def recent_commits(current_user)
    CommitSearchResult.new(GithubService.user_commits(current_user.token, nickname)).all_commits
  end
end
