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

    describe '#game_loop' do
        before(:each) do
            @gameplay = GameLogic.new
            @gameplay.player_board = Board.new
            @gameplay.computer_board = Board.new
            @cruiser = Ship.new('Cruiser', 3)
            @submarine = Ship.new('Submarine', 2)

            @gameplay.player_board.place(@cruiser, ['A1', 'A2', 'A3'])
            @gameplay.player_board.place(@submarine, ['C1', 'C2'])
            @gameplay.computer_board.place(@cruiser, ['A1', 'A2', 'A3'])
            @gameplay.computer_board.place(@submarine, ['C1', 'C2'])
        end

        it 'continues while ships on user side still stand' do
        end

        it 'continues while ships on computer side still stand' do
        end

        it 'ends when all ships on user side are sunk' do
        end

        it 'ends when all ships on computer side are sunk' do
        end

        it 'gets user input for shot' do  
            #require 'pry';binding.pry
            #expect `@gameplay.game_loop` 
            # to give:
            #   Enter your next shot: 
            #   NoMethodError:
        end

        it 'checks if shot is valid or been shot before' do
            expect(@gameplay.new_shot('A1', @gameplay.player_board)).to eq true
            expect(@gameplay.new_shot('A1', @gameplay.player_board)).to eq false
        end

        it 'has computer take a shot' do
        end

        it 'updates ship if hit' do
        end

        it 'checks if ship is sunk' do
        end

        it 'checks if sunk ship is last standing ship' do
        end

        it 'updates computer board with user shot' do
            shot_1 = @gameplay.user_shot('A1')
            expect(@gameplay.computer_board.cells['A1'].fired_upon?).to be true
        end
           
        it 'updates player board with computer shot' do
            shot_2 = @gameplay.computer_shot
            expect(@gameplay.player_board.cells['A1'].fired_upon?).to be true
        end

        it 'gives user feedback on shots fired' do
            shot_1 = @gameplay.user_shot('A1')
            shot_2 = @gameplay.computer_shot

            expect(@gameplay.feedback(shot_1, shot_2)).to eq "You hit a ship!\nThe computer hit one of your ships"
        end

        it 'cycles back to top of turn' do
        end
    end
end