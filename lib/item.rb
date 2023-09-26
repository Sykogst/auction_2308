class Item
  attr_reader :name
  def initialize(item_name)
    @name = item_name
    @bids = {}
  end
end