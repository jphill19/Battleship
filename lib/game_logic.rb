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
            shot_1 = user_shot(user_coords)
            shot_2 = computer_shot
        end
    end

    def new_shot(coordinate, board)
        if board.cells[coordinate] != 'na'
            if !board.cells[coordinate].fired_upon?
                return shot_hit?(board.cells[coordinate], board)
            else
                puts "Already fired at this coordinate. Try again: "
                user_coords = (gets.chomp).capitalize()
                user_shot(user_coords)
            end
        else
            false
        end
    end

    def user_shot(user_input)
        new_shot(user_input, @computer_board)
    end

    def computer_shot
        new_shot(computer_input, @player_board)
    end

    def computer_input
        return 'A1'
    end

    def shot_hit?(cell, board)
        cell.fire_upon
        if !cell.empty?
            if cell.ship.sunk?
                board.ships.delete(cell.ship)
                return 'sunk'
            end
            true
        else
            false
        end
    end

    def ships_sunk?(board)
        board.ships.count < 1
    end

    def feedback(shot_1, shot_2)
        response = []
        if shot_1 == 'sunk'
            response << "You sunk a ship!!!\n"
        elsif shot_1 == true
            response << "You hit a ship!\n"
        else
            response << "You missed your shot...\n"
        end

        if shot_2 == 'sunk'
            response << "The computer sunk one of your ships"
        elsif shot_2 == true
            response << "The computer hit one of your ships"
        else
            response << "The computer missed your ships!!"
        end
        response.join
    end

end