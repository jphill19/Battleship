require 'spec_helper'

RSpec.describe GameLogic do
    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
      
    end

    describe 'Initialize' do
        it 'exists' do
            expect(@board).to be_an_instance_of Board
        end
    end
end