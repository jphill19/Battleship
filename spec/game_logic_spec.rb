require 'spec_helper'

RSpec.describe GameLogic do
    before(:each) do
    #   @board = Board.new
    #   @cruiser = Ship.new("Cruiser", 3)
    #   @submarine = Ship.new("Submarine", 2)
      @game_logic = GameLogic.new

    end

    describe 'Initialize' do
        it 'exists' do
            expect(@game_logic).to be_an_instance_of GameLogic
        end
    end
end