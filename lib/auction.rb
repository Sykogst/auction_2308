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

  def each_item_highest_bid
    highest_bids = Hash.new
    @items.each do |item|
      all_bids = item.bids
      max_bidder = all_bids.max_by { |attendee, amount| amount }
      highest_bids[item] = max_bidder
    end
    item_bids = highest_bids.compact
    item_bids.reduce({}) do |final, (item, high_bid)|
      final[item] = high_bid[1]
      final
    end
  end
end