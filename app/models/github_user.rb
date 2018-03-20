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

  def initialize(attrs = {})
    @name = attrs[:name]
    @avatar_url = attrs[:avatar_url]
    @nickname = attrs[:login]
    @bio = attrs[:bio]
    @location = attrs[:location]
    @blog_url = attrs[:blog]
    @repositories_count = attrs[:public_repos]
    @stars_count = '##'
    @followers_count = attrs[:followers]
    @following_count = attrs[:following]
  end
end
