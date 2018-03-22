class CommitSearchResult
  def initialize(response)
    @total_count = response[:total_count]
    @incomplete_results = response[:incomplete_results]
    @items = response[:items]
  end

  def all_commits
    items.map do |item|
      Commit.new(item)
    end
  end

  private
  attr_reader :items
end
