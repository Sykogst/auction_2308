require './spec/spec_helper'

RSpec.describe Auction do
  before(:each) do
    @auction = Auction.new

    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@auction).to be_instance_of(Auction)
    end

    it 'has attributes' do
      expect(@auction.items).to eq([])
    end
  end

  describe '#add_item' do
    it 'add items to list' do
      expect(@auction.items).to eq([])

      @auction.add_item(@item1)
      expect(@auction.items).to eq([@item1])

      @auction.add_item(@item2)
      expect(@auction.items).to eq([@item1, @item2])
    end
  end

  describe '#unpopular_items' do
    it 'returns list of item OBJ with no bids' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      expect(@auction.unpopular_items).to eq([@item1, @item2, @item3, @item4, @item5])


      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])
      
      @item3.add_bid(@attendee2, 15)
      expect(@auction.unpopular_items).to eq([@item2, @item5])
    end
  end

  describe '#potential_revenue, #each_item_highest_bid' do
    before(:each) do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
    end

    it 'returns highest bid for each item' do
      expect(@auction.each_item_highest_bid).to eq({@item1 => 22, @item4 => 50, @item3 => 15})
    end

    it 'returns total of highest bid from each item' do
      expect(@auction.potential_revenue).to eq(87)
    end
  end

  describe '#bidders' do
    it 'returns array of bidders names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      expect(@auction.bidders).to eq([])

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      expect(@auction.bidders).to eq(['Bob', 'Megan', 'Mike'])
    end
  end

  describe '#bidder_info, #attendee_item_bids' do
    before(:each) do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
    end
  # hash; Attendee OBJ => subHash
  # subHash; budget: budget value INT, items: array of items
    it 'returns attendee and items bid on' do
      expect(@auction.attendee_item_bids(@attendee2)).to eq([@item1, @item3])
    end

    it 'returns attendee OBJ with budget INT and items OBJ bid on' do
      expect(@auction.bidder_info).to eq({ @attendee2 => { budget: 75, items: [@item1, @item3] },
                                           @attendee1 => { budget: 50, items: [@item1] },
                                           @attendee3 => { budget: 100, items: [@item4] }
                                        })
    end
  end

  describe '#date' do
  # Really uncertain if this is properly done...
    it 'returns date string' do
      old_date = allow(Date).to receive(:date).and_return('21/08/2023')
    end
  end

  describe '#close_auction, #each_item_highest_attendee' do
    # Purchase only what can be afforded
    # Multiple bids - Most expensive to least expensive
    # Out of budget, next highest bidder wins
    xit 'items, each with highest bidding attendee' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 70)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      @item3.add_bid(@attendee3, 20)

      expect(@auction.each_item_highest_attendee).to eq({@item1 => @attendee2, 
                                                         @item2 => nil, 
                                                         @item3 => @attendee3, 
                                                         @item4 => @attendee3, 
                                                         @item5 => nil
                                                        })
    end

    xit 'items, attendee that won or not sold' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 70)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      @item3.add_bid(@attendee3, 20)

      expect(@auction.close_auction).to eq({@item1 => @attendee1,
                                            @item2 => 'Not Sold',
                                            @item3 => @attendee3,
                                            @item4 => @attendee3,
                                            @item5 => 'Not Sold',
                                          })
    end
  end
end