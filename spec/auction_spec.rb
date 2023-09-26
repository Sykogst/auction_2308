require './spec/spec_helper'

RSpec.describe Auction do
  before(:each) do
    @auction = Auction.new

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
end