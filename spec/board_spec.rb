require 'spec_helper'

RSpec.describe Board do
    before(:each) do
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

    describe '#valid_placement?' do
        describe '#match_length?' do
            it 'reads the arguments' do
                coordinates = ['A1', 'B1', 'C1']
                expect(@board.match_length?(@cruiser, coordinates)).to eq true
            end

            it 'returns false if argument lengths dont match' do
                coordinates = ['A1', 'C1']
                expect(@board.match_length?(@cruiser, coordinates)).to eq false
            end
        end

        describe '#straight_line?' do
            it 'checks all the coordinates first element' do
            end

            it 'checks all the coordinates second element' do
            end

            it 'returns true if either element is all the same' do
            end

            it 'returns false if all elements are non-consecutive' do
            end
        end

        describe '#consecutive_check?' do
            it 'checks the non-consecutive element to see if it increments by one' do
            end

            it 'returns true if the elements are consecutive' do
            end

            it 'returns false if the elements are not consecutive' do
            end
        end

        describe '#overlap?' do
            it 'checks each cell to see if a ship has already been placed' do
            end

            it 'returns true if any cell already contains a ship' do
            end

            it 'returns false if all cells are empty' do
            end
        end
    end

    describe '#place' do
    end
end
