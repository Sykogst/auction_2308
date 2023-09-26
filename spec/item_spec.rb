require './spec/spec_helper'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')

    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@item1).to be_instance_of(Item)
    end

    it 'has attributes' do
      expect(@item1.name).to eq('Chalkware Piggy Bank')
      expect(@item1.instance_variable_get(:@bids)).to eq({})
      expect(@item1.instance_variable_get(:@closed)).to be false

      expect(@item2.name).to eq('Bamboo Picture Frame')
      expect(@item2.instance_variable_get(:@bids)).to eq({})
      expect(@item1.instance_variable_get(:@closed)).to be false
    end
  end

  describe '#add_bid' do
    it 'update bids with attendee OBJ and bid number' do
      expect(@item1.bids).to eq({})

      @item1.add_bid(@attendee2, 20)
      expect(@item1.bids).to eq({@attendee2 => 20})

      @item1.add_bid(@attendee1, 22)
      expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})
    end
  end

  describe '#current_high_bid' do
    it 'returns highest bid for item' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})

      expect(@item1.current_high_bid).to eq(22)
    end
  end

  describe '#close_bidding, #closed?' do
    it 'returns auction status' do
      expect(@item1.closed?).to be false

      @item1.close_bidding
      expect(@item1.closed?).to be true
    end

    it 'no longer allows bidding when closed' do
      expect(@item1.bids).to eq({})
      expect(@item1.closed?).to be false
      @item1.add_bid(@attendee2, 20)
      expect(@item1.bids).to eq({@attendee2 => 20})

      @item1.close_bidding
      expect(@item1.closed?).to be true
      expect(@item1.add_bid(@attendee1, 25)).to eq('Cannot bid, auction for item is closed')

      @item2.add_bid(@attendee1, 25)
      expect(@item2.bids).to eq({@attendee1 => 25})
    end
  end
end