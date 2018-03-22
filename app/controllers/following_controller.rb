class FollowingController < ApplicationController
  def index
    @following = FollowingList.new(current_user.token)
  end

  def show
  end
end
