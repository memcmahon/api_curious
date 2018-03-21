class UsersController < ApplicationController
  def show
    @github_user = GithubUser.create(current_user.token)
  end
end
