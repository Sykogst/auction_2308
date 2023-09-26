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

  def potential_revenue
    highe_bids = each_item_highest_bid.values
    highe_bids.reduce(0) { |sum, bid| sum += bid }
  end

  def bidders
    @items.reduce([]) do |names, item|
      bid_attendee = item.bids.keys
      bid_attendee.each do |bid|
        names << bid.name
      end
      names.uniq
    end
  end

  def attendee_item_bids(attendee)
    items_bid_on = []
    @items.each do |item|
      bidders = item.bids.keys
      bidders.each do |bidder|
        items_bid_on << item if bidder.name == attendee.name
      end
    end
    items_bid_on
  end

  def bidder_info
    @items.reduce({}) do |bidder_info, item|
      item.bids.each do |attendee, bid|
        bidder_info[attendee] = Hash[budget: attendee.budget, items: attendee_item_bids(attendee)]
      end
      bidder_info
    end
  end
end