class GameLogic

    attr_accessor :computer_board,
                  :player_board

    def initialize
        @computer_board = nil
        @player_board = nil
    end
    
    def game_loop
        until ships_sunk?(@computer_board) || ships_sunk?(@player_board)
            puts "Enter your next shot: "
            user_coords = gets.chomp
            user_shot(user_coords)
            computer_shot
        end
    end

    def new_shot(coordinate, board)
        if !board.cells[coordinate].fired_upon?
            shot_hit?(board.cells[coordinate], board)
        else 
            puts "Already fired at this coordinate. Try again: "
            user_coords = (gets.chomp).capitalize()
            user_shot(user_coords)
        end
    end

    def user_shot(user_input)
        new_shot(user_input, @player_board)
    end

    def computer_shot
        new_shot(computer_input, @computer_board)
    end

    def shot_hit?(cell, board)
        cell.fire_upon
        if !cell.empty?
            if cell.ship.sunk?
                board.ships.delete(cell.ship.name)
            end
        end
    end

    def ships_sunk?(board)
        board.ships.count < 1
    end

    def feedback
    end

end