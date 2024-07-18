require 'spec_helper'


RSpec.describe Cell do
  before(:each) do
    @cell_1 = Cell.new("B4")
    @ship = Ship.new("Cruiser", 3)
  end

  describe "#initialize" do
    it "can initialize" do
      expect(@cell_1).to be_an_instance_of(Cell)
      expect(@cell_1.coordinate).to eq("B4")
    end
  end

  describe "#empty?" do
    it "returns true if empty" do
      expect(@cell_1.empty?).to eq(true)
    end

    it "returns false if not empty" do
      @cell_1.place_ship(@ship)

      expect(@cell_1.empty?).to eq(false)
    end
  end

  describe "#place_ship" do
    it "will add a ship object to ship attribute" do
      @cell_1.place_ship(@ship)

      expect(@cell_1.ship).to be_an_instance_of Ship
    end
  end

  describe "#fire_upon?" do
    it 'checks that cell is not shot' do
      expect(@cell_1.fired_upon?).to eq false
    end

    it 'checks that cell is shot' do
      expect(@cell_1.fired_upon?).to eq false
      @cell_1.fire_upon

      expect(@cell_1.fired_upon?).to eq true
    end

    it 'integrates ship_hit with fire_upon' do
      expect(@cell_1.fired_upon?).to eq false
      @cell_1.place_ship(@ship)
      @cell_1.fire_upon

      expect(@cell_1.fired_upon?).to eq true
      expect(@cell_1.ship.health).to eq 2
    end
  end

  describe "#ship_hit" do
    it 'should not decrease any ship health on empty cell' do
      expect(@cell_1.ship_hit).to eq false
    end

    it 'makes ship health decrease on hit' do
      @cell_1.place_ship(@ship)
      expect(@cell_1.ship.health).to eq 3
      @cell_1.ship_hit

      expect(@cell_1.ship.health).to eq 2
    end
  end

  describe "#render" do
    it "returns '.' if it has not been fired upon" do
      expect(@cell.render).to eq('.')
    end

    it "returns 'M' if it has been fired upon and does not contain a ship" do
      expect(@cell.render).to eq('M')
    end

    it "returns 'H' if it has been fired upon and contains a ship" do
      expect(@cell.render).to eq('H')
    end

    it "returns 'X' if the ship has been sunk" do
      expect(@cell.render).to eq('X')
    end

    it "returns 'S' if ships present & not fired upon & users board" do

    end

    it "returns '.' if the ships present, not fired upon but computers board"

    end
  end
end