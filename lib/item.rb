class Item
  attr_reader :name, :bids
  def initialize(item_name)
    @name = item_name
    @bids = {}
    @closed = false
  end

  def add_bid(attendee, bid_amount)
    no_bid_memo = 'Cannot bid, auction for item is closed'
    closed? ? no_bid_memo : @bids[attendee] = bid_amount
  end

  def current_high_bid
    max_bidder = @bids.max_by { |attendee, bid_amt| bid_amt }
    max_bidder[1]
  end

  def closed?
    @closed
  end

  def close_bidding
    @closed = true
  end
end