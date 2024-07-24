require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/computer_brain_2'

class GameLogic

    attr_accessor :computer_board,
                  :player_board,
                  :computer_coordinates

    def initialize
        @computer_board = nil
        @player_board = nil
        @computer_coordinates = nil
        @available_ships = {
            1 => {
                :name => "submarine",
                :length => 2
            },

            2 => {
                :name => "cruiser",
                :length => 3
            },

            3 => {
                :name => "destroyer",
                :length => 4
            },

            4 => {
                :name => "battleship",
                :length => 5
            },

            5 => {
                :name => "carrier",
                :length => 6
            }

        }
    @empty_cells_for_ship_placement = []
    @user_ships_selected = []
    @available_user_shots = []
    @computer_brain = nil
    
    end
    
    def main_menu
        puts "\nWelcome to BATTLESHIP\n"
        if ask_user_to_play
            set_up_boards
            computer_shot_possibilities
            setup_computer_brain
            puts "*********************************************************" + "\n\e\t[34mPrepare yourself for Battle!\n\n\e[0m"
            game_loop
            puts "Thanks for playing, have a nice day!"
        end
    end

    def ask_difficulty_level
        puts "\nEnter your diffuclty level you want to play with \n\nInput 1 | Easy\nInput 2 | Hard"
        user_input = gets.chomp.to_i
        return true if user_input.to_i == 2
        return false if user_input.to_i == 1
        puts puts "\e[31mDont recognize your input, try again!\e[0m\n\n"
        ask_difficulty_level
    end

    def setup_computer_brain
        @computer_brain = nil
        difficuluty_level = ask_difficulty_level
        @computer_brain = ComputerBrain.new(@player_board) if difficuluty_level
    end

    def ask_user_to_play
        puts "Enter p to play. Enter q to quit."
        main_menu_input = gets.chomp
        if main_menu_input.downcase == 'p'
            return true
        elsif main_menu_input.downcase == 'q'
            return false
        else
            puts "\e[31mDont recognize your input, try again!\e[0m\n\n"
            ask_user_to_play
        end
    end

    def set_up_boards
        puts "\n\t\t\tNEW GAME!" + "\n---------------------------------------------------------\n"
        users_size = [ask_user_row_size, ask_user_column_size]
        ships_size_limit = users_size.max
        @player_board = Board.new((users_size[0] + 64).chr, users_size[1])
        @computer_board = Board.new((users_size[0] + 64).chr, users_size[1])
        place_ships_user(ships_size_limit)
        place_computer_ships
    end

    def ask_user_column_size
        puts "\nHow many columns would you like your board to have? Input a number between 4-10"
        columns = gets.chomp
        if columns.to_i >= 4 &&  columns.to_i <= 10
            return columns.to_i
        end
        puts "Error, try again!"
        ask_user_column_size
    end

    def ask_user_row_size
        puts "\nHow many rows would you like your board to have? Input a number between 4-10"
        rows = gets.chomp
        if rows.to_i >= 4 &&  rows.to_i <= 10
            return rows.to_i
        end
        puts "Error, try again!"
        ask_user_row_size
    end

    def place_computer_ships
        gather_empty_cells
        @user_ships_selected.each do |ship|
            placed = false
            while !placed
                placed = find_random_spot(ship)
            end
        end
        wipe_user_ships_selected
    end

    def wipe_user_ships_selected
        @user_ships_selected = []
    end

    def gather_empty_cells
        @empty_cells_for_ship_placement = @computer_board.cells.keys
    end

    def update_empty_cells_for_ship_placement(coordinates)
        @empty_cells_for_ship_placement = @empty_cells_for_ship_placement - coordinates
    end


    def find_random_spot(ship)
        rand(2) == 0 ? column_placement_attempt(ship, random_board_spots_value) : row_placement_attempt(ship, random_board_spots_value)
    end

    def random_board_spots_value
        @empty_cells_for_ship_placement.sample.split('')
    end

    def column_placement_attempt(ship, spot)
        low_row =  spot[0].ord - ship[:length]
        new_ship = Ship.new(ship[:name], ship[:length])
        coordinates = ((low_row + 1).chr .. spot[0]).to_a.map { |letter| "#{letter}1"}

        if low_row >= 64 && @computer_board.valid_placement?(new_ship, coordinates)
            @computer_board.place(new_ship, coordinates)
            update_empty_cells_for_ship_placement(coordinates)
            return true
        end
        false
    end

    def row_placement_attempt(ship, spot)
        col_num = spot[1].to_i
        low_col = col_num - ship[:length]
        new_ship = Ship.new(ship[:name], ship[:length])
        coordinates = (low_col + 1 .. col_num).to_a.map { |num| "#{spot[0]}#{num}" }

        if low_col >= 0 && @computer_board.valid_placement?(new_ship, coordinates)
            @computer_board.place(new_ship, coordinates)
            update_empty_cells_for_ship_placement(coordinates)
            return true
        end
        false
    end

    def place_ships_user(ships_size_limit)
        @user_ships_selected = []
        setting_board = true
        while setting_board
            puts "*********************************************************" + "\nSelect ships to place on your board!\n\nCurrent board setup:\n\n" + @player_board.render(true)
            present_ships(ships_size_limit)
            user_response_data = ask_user_input(ships_size_limit)
            setting_board = false if user_response_data
        end
    end

    def available_ships_for_size_limit(ships_size_limit)
        available_ships_limited = @available_ships.find_all do |key, ship|
            ship[:length] <= ships_size_limit
        end.to_h
        available_ships_limited.keys
    end

    def ask_user_input(ships_size_limit)
        puts "\nSelect the ship you would like. Input: 'done' when finished!"
        users_input = gets.chomp
        if users_input.downcase == "done" && @player_board.ships.length == 0
            puts "\nPlease place a ship before moving on"
            return false
        elsif users_input.downcase == 'done'
            return true
        elsif available_ships_for_size_limit(ships_size_limit).include?(users_input.to_i)
            user_place_ship(@available_ships[users_input.to_i])
            return false
        else
            puts "\e[31mDont recognize your input, try again!\e[0m\n"
=======
        @computer_coordinates = nil
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
        guess = computer_input
        computer_shuffle(guess)
        new_shot(guess, @player_board)
        guess
    end

    def computer_shot_possibilities
        @computer_coordinates = @player_board.cells.keys
    end

    def computer_input
        @computer_coordinates.sample
    end

    def computer_shuffle(shot)
        @computer_coordinates.delete(shot)
        @computer_coordinates.shuffle!
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

    def user_coordinates_input(ships_length)
        puts "\nInput the Coordinates where you want your ship place. Example of valid input: '#{proper_length(ships_length)}'\nTo cancel input: 'cancel'"
        user_input = gets.chomp
        coordinates = user_input.split(",").map { |coordinate| coordinate.strip.upcase }
    end

    def proper_length(ships_length)
        example = ""
        ships_length.times do |num|
            example += " A#{num+1},"
        end
        example
    end

    def user_place_ship(user_selected_ship)
        new_ship = Ship.new(user_selected_ship[:name],user_selected_ship[:length])
        while true
            puts "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" + "\nSelected ship #{user_selected_ship[:name]} which is #{user_selected_ship[:length]} cells long.\nWhere would you like to place it on the board?\n" + @player_board.render(true)
            coordinates_input = user_coordinates_input(user_selected_ship[:length])

            if coordinates_input[0] == 'CANCEL'
                return false
            elsif @player_board.valid_placement?(new_ship, coordinates_input)
                @player_board.place(new_ship,coordinates_input)
                @user_ships_selected << user_selected_ship
                return true
            else
                puts "\e[31mInvalid input, try again!\e[0m"
            end
        end
    end

    def present_ships(ships_size_limit)
        puts "\nShips available for your fleat!\n"
        @available_ships.each do |key,value|
            if value[:length] <= ships_size_limit
                puts "Input: #{key} | Ship: #{value[:name].capitalize}\t| Length: #{value[:length]}"
            end
        end
=======
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


    def display_boards
        puts "----------------------------------------------------------\n\n"
        puts " \e[31mEnemys Board\e[0m\n\n" + @computer_board.render
        puts "\n\n \e[32mYour Board\e[0m\n\n" + @player_board.render(true)
    end

    
    
    def game_loop
        available_user_shots_set
        until ships_sunk?(@computer_board) || ships_sunk?(@player_board)
            display_boards
            puts "\n\nEnter your next shot: "
            user_coords = user_shot_input
            shot_1 = user_shot(user_coords)
            shot_2 = computer_shot
            puts feedback(shot_1, shot_2)
            sleep(2)
        end
        end_game
    end

    def end_game
        puts "\n\n*********************************************************"
        puts "\tGame Over!"
        display_boards
        if user_won?
            puts "\n\n\e[32mYou are Victorious! 🎉🎊\e[0m"
            main_menu
        end
        puts "\n\n\e[31mYou have been defeated. 😞\e[0m"
        main_menu
    end

    def user_won?
        ships_sunk?(@computer_board) 
    end



    def available_user_shots_set
        @available_user_shots = @computer_board.cells.keys
    end

    def update_available_user_shots(shot_to_remove)
        @available_user_shots.delete(shot_to_remove)
    end

    def verify_shot_is_available(shot)
        @available_user_shots.include?(shot)
    end

    def user_shot_input
        user_shot_attempt = gets.chomp
        user_shot_attempt_sanitized = user_shot_attempt.upcase
        unless verify_shot_is_available(user_shot_attempt_sanitized)
            puts "\n\e[31mInvalid input, try again!\e[0m"
            return user_shot_input
        end
        update_available_user_shots(user_shot_attempt_sanitized)
        return user_shot_attempt_sanitized
    end

    def new_shot(coordinate, board)
        return false if board.cells[coordinate] == 'na'
        return shot_hit?(board.cells[coordinate], board) unless board.cells[coordinate].fired_upon? 
        puts "Already fired at this coordinate. Try again: "
        user_coords = user_shot_input
        user_shot(user_coords)
    end

    def user_shot(user_input)
        new_shot(user_input, @computer_board)
    end

    def computer_shot
        guess = computer_input
        computer_shuffle(guess)
        new_shot(guess, @player_board)
    end

    def computer_shot_possibilities
        @computer_coordinates = @player_board.cells.keys
    end

    def computer_input
        return @computer_brain.decide_shot if @computer_brain
        @computer_coordinates.sample
    end

    def computer_shuffle(shot)
        @computer_coordinates.delete(shot)
        @computer_coordinates.shuffle!
    end

    def shot_hit?(cell, board)
        cell.fire_upon
        return false if cell.empty?
        if cell.ship.sunk?
          board.ships.delete(cell.ship)
          return 'sunk'
        end
        true
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