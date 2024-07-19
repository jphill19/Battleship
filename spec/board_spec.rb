require 'spec_helper'

RSpec.describe Board do
    before(:each) do
    #   A1 = Cell.new("A1")
    #   A2 = Cell.new("A2")
    #   A3 = Cell.new("A3")
    #   B1 = Cell.new("B1")
    #   B2 = Cell.new("B2")
    #   B3 = Cell.new("B3")
    #   C1 = Cell.new("C1")
    #   C2 = Cell.new("C2")
    #   C3 = Cell.new("C3")
    #   @cells = [A1, A2, A3, B1, B2, B3, C1, C2, C3]
    #   @board = Board.new(@cells)
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
    end

    describe 'Initialize' do
        it 'exists' do
            expect(@board).to be_an_instance_of Board
        end

        it 'creates board cells, and its equal to a hash' do
            expect(@board.cells).to be_truthy
            expect(@board.cells.class).to eq(Hash)
        end
        it 'The board cells values are cell objects ' do
            expect(@board.cells["A1"]).to be_an_instance_of Cell
            expect(@board.cells["A1"].coordinate).to eq("A1")
        end

    end

    describe '#valid_coordinate?' do
        it 'verifies the arguemnt is on the board' do
            expect(@board.valid_coordinate?("A1")).to eq true
            expect(@board.valid_coordinate?("B3")).to eq true
        end

        it 'catches if the arguement is not on the board' do
            expect(@board.valid_coordinate?("A22")).to eq false
            expect(@board.valid_coordinate?("dog")).to eq false
        end
    end

    describe '#valid_placement' do
    end

    describe '#place' do
    end
end
