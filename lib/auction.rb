class Auction
  attr_reader :items
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def unpopular_items
    @items.reduce([]) do |no_bids, item|
      no_bids << item if item.bids == {}
      no_bids
    end
  end
end