class Commit
  attr_reader :message, :date, :repository

  def initialize(info)
    @message = info[:commit][:message]
    @date = info[:commit][:committer][:date].gsub("T", " ")
    @repository = info[:repository][:full_name]
  end
end
