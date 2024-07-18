require 'spec_helper'


RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @ship = Ship.new("Cruiser", 3)
  end

  describe "#initialize" do
    it "can initialize" do
      expect(@cell).to be_an_instance_of(Cell)
      expect(@cell.coordinate).to eq("B4")
    end
  end

  describe "#empty?" do
    it "returns true if empty" do
      expect(@cell.empty?).to eq(true)
    end

    it "returns false if not empty" do
      @cell.place_ship(@ship)

      expect(@cell.empty?).to eq(false)
    end
  end

  describe "#place_ship" do
    it "will add a ship object to ship attribute" do
      @cell.place_ship(@ship)

      expect(@cell.ship).to be_an_instance_of Ship
    end
  end

  describe "#fire_upon?" do
    it 'checks that cell is not shot' do
      expect(@cell.fired_upon?).to eq false
    end

    it 'checks that cell is shot' do
      expect(@cell.fired_upon?).to eq false
      @cell.fire_upon

      expect(@cell.fired_upon?).to eq true
    end
  end

  describe "#ship_hit" do
    it 'checks if ship is present' do
      
    end
    
    it 'should not decrease any ship health on empty cell' do
    end

    it 'makes ship health decrease on hit' do
    end
  end
end