class Following
  def initialize(token)
    @token = token
  end

  def all
    GithubService.following(@token).map do |user|
      GithubUser.new(user)
    end
  end
end
