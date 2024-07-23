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

    describe '#game_loop' do
        before(:each) do
            @gameplay = GameLogic.new
            @gameplay.player_board = Board.new
            @gameplay.computer_board = Board.new
            @cruiser = Ship.new('Cruiser', 3)
            @submarine = Ship.new('Submarine', 2)

            @gameplay.player_board.place(@cruiser, ['A1', 'A2', 'A3'])
            @gameplay.computer_board.place(@cruiser, ['A1', 'A2', 'A3'])
            @gameplay.computer_board.place(@submarine, ['C1', 'C2'])
            @gameplay.computer_shot_possibilities
        end

        it 'gets user input for shot' do  
            #require 'pry';binding.pry
            #expect `@gameplay.game_loop` 
            # to give:
            #   Enter your next shot: 
            #   NoMethodError:
        end

        xit 'checks if shot is valid or been shot before' do
            expect(@gameplay.new_shot('A1', @gameplay.player_board)).to eq true
            expect(@gameplay.new_shot('A1', @gameplay.player_board)).to eq false
        end

        it 'checks if ship is sunk' do
            expect(@gameplay.new_shot('A1', @gameplay.player_board)).to eq true

            @gameplay.new_shot('A2', @gameplay.player_board)
            expect(@gameplay.new_shot('A3', @gameplay.player_board)).to eq 'sunk'
        end

        it 'checks if sunk ship is last standing ship' do
            expect(@gameplay.ships_sunk?(@gameplay.player_board)).to eq false
            @gameplay.new_shot('A1', @gameplay.player_board)
            @gameplay.new_shot('A2', @gameplay.player_board)
            @gameplay.new_shot('A3', @gameplay.player_board)
            expect(@gameplay.ships_sunk?(@gameplay.player_board)).to eq true

        end

        it 'updates computer board with user shot' do
            shot_1 = @gameplay.user_shot('A1')
            expect(@gameplay.computer_board.cells['A1'].fired_upon?).to be true
        end
           
        it 'updates player board with computer shot' do
            shot_2 = @gameplay.computer_shot
            expect(@gameplay.player_board.cells[shot_2].fired_upon?).to be true
        end

        it 'gives user feedback on shots fired' do
            shot_1 = @gameplay.user_shot('A1')
            shot_2 = @gameplay.computer_shot

            expect(@gameplay.feedback(shot_1, shot_2)).to include "You hit a ship!\n"
        end

        describe '#computer_shot' do
            before(:each) do
                @gameplay = GameLogic.new
                @gameplay.player_board = Board.new
                @gameplay.computer_board = Board.new
                @cruiser = Ship.new('Cruiser', 3)
                @submarine = Ship.new('Submarine', 2)

                @gameplay.player_board.place(@cruiser, ['A1', 'A2', 'A3'])
                @gameplay.computer_board.place(@cruiser, ['A1', 'A2', 'A3'])
                @gameplay.computer_board.place(@submarine, ['C1', 'C2'])
            end

            it 'creates an array of possible shots' do
                @gameplay.computer_shot_possibilities
                expect(@gameplay.computer_coordinates).to eq ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
            end

            it 'draws a random selection from the array' do
                @gameplay.computer_shot_possibilities
                expect(@gameplay.computer_input).to be_a String
                expect(@gameplay.computer_coordinates).to include @gameplay.computer_input
            end

            it 'removes the shot from the possibilities' do
                @gameplay.computer_shot_possibilities
                guess = @gameplay.computer_input
                expect(guess).to be_a String
                expect(@gameplay.computer_coordinates).to include guess
                expect(@gameplay.computer_coordinates.count).to eq 16

                @gameplay.computer_shuffle(guess)
                expect(@gameplay.computer_coordinates).not_to include guess
                expect(@gameplay.computer_coordinates.count).to eq 15
            end
        end
    end
end