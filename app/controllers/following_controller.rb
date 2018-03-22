class FollowingController < ApplicationController
  def index
    @following = Following.new(current_user.token).all
  end

  def show
  end
end
