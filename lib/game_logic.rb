class GameLogic

    attr_reader

    def initialize
        @computers_board = nil
        @player_board = nil
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
    end
    
    def set_up_boards
        @users_size = [ask_user_row_size, ask_user_column_size]
        ships_size_limit = @users_size.max
        @player_board = Board.new((@users_size[0] + 64).chr, @users_size[1])
        @computer_board = Board.new((@users_size[0] + 64).chr, @users_size[1])
        place_ships_user(ships_size_limit)
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

    def place_ships_user(ships_size_limit)
        @user_ships_selected = []
        setting_board = true
        while setting_board
            puts "*********************************************************"
            puts "Select ships to place on your board!\n\nCurrent board setup:\n"
            puts @player_board.render(true)
            present_ships(ships_size_limit)
            user_response_data = ask_user_input(ships_size_limit)
            if user_response_data
                setting_board = false
            end
        end
    end

    def ask_user_for_ships
        ships_selected = []
        puts "Select which you would like to use and then place them!"
        continue_asking = false
        while continue_asking
            display_users_selected_ships(ships_selected)
            present_ships
            puts "\nEnter 'done' when finished"
        end

    end

    def display_users_selected_ships(ships_selected)
        user_ships_feedback = "Current Ships in your fleat:"
        ships_selected.each do |ship|
            user_ships_feedback += ", #{ship[:name]}"
        end
        puts user_ships_feedback
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
        if users_input.downcase == 'done' && @player_board.ships.length > 0
            puts "\nPlease place a ship before moving on"
            return false
        elsif users_input.downcase == 'done'
            puts "\nPrepare yourself for Battle!"
            return true
        elsif available_ships_for_size_limit(ships_size_limit).include?(users_input.to_i)
            user_place_ship(@available_ships[users_input.to_i])
            return false
        else
            puts "\e[31mDont recognize your input, try again!\e[0m\n"
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
            puts coordinates_input
            if coordinates_input[0] == 'CANCEL'
                return false
            elsif @player_board.valid_placement?(new_ship, coordinates_input)
                @player_board.place(new_ship,coordinates_input)
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
    end

end