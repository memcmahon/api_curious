class UsersController < ApplicationController
  def show
    @github_user = GithubUser.create(current_user.token)
    binding.pry
    @commit_feed = @github_user.commit_feed(current_user.token)
  end
end
