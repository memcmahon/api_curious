class Event
  def initialize(event)
    @type = event[:type]
    @commits = event[:commits].count if event[:commits]
    @repository = event[:repo][:name]
    @date = event[:created_at]
  end
end
