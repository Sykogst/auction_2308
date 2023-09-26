class Item
  attr_reader :name, :bids
  def initialize(item_name)
    @name = item_name
    @bids = {}
  end

  def add_bid(attendee, bid_amount)
    @bids[attendee] = bid_amount
  end

  def current_high_bid
    max_bidder = @bids.max_by { |attendee, bid_amt| bid_amt }
    max_bidder[1]
  end
end