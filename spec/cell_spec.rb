require 'spec_helper'


RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
  end

  describe "#initialize" do
    it "can initialize" do
      expect(@cell).to be_an_instance_of(Cell)
      expect(@cell.coordinate).to eq("B4")
    end
  end

end