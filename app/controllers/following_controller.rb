class FollowingController < ApplicationController
  def index
    @following = Following.new(current_user.token).all
  end

  def show
    @events = Events.new(params[:username]).commits
  end
end

class Events
  def initialize(username)
    @username = username
  end

  def pages
    GithubService.event_pages(@username)[:link].split("page=")[2].to_i
  end


  def commits
    events = []
    pages.times do |n|
      events << GithubService.events(@username, n+1)
    end
    events.flatten.map do |event|
      EventCommit.new if event[:type] == "PushEvent"
    end
  end
end
