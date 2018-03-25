class FollowingController < ApplicationController
  def index
    @following = Following.new(current_user.token).all
  end

  def show
    @events = Events.new(params[:username]).all
  end
end

class Events
  def initialize(username)
    @username = username
  end

  def pages
    binding.pry
    GithubService.event_pages(@username)[:link].split("page=")[2].to_i
  end


  def all
    events = []
    pages.times do |n|
      events << GithubService.events(@username, n+1)
    end
    events.flatten.map do |event|
      Event.new(event)
    end
  end
end
