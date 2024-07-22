class GameLogic

    attr_reader

    def initialize
        @computers_board = nil
        @players_board = nil
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
    
    def set_up_user_board
        @users_size = [ask_user_row_size, ask_user_column_size]
        ships_size_limit = @users_size.max
        @players_board = Board.new((@users_size[0] + 64).chr, @users_size[1])

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

    def place_ships(ships_size_limit)
        ships_selected = []
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

    def ask_user_input(ships_size_limit)
        users_input = gets.chomp
        if users_input.downcase == 'done' && @players_board.ships.length > 0
            puts "\nPlease place a ship before moving on"
            return {:move_on => false, :ship => false}
        elsif users_input.downcase == 'done'
            puts "\nPrepare yourself for Battle!"
            return {:move_on => true, :ship => false}
        elsif user_input.to_i <= ships_size_limit && @available_ships.keys.include?(user_input.to_i)
            user_place_ship(@available_ships[user_input.to_i])
            return {:move_on => false, :ship => @available_ships[user_input.to_i]}
        else

        end
            
        


    end

    def user_place_ship(user_selected_ship)
        new_ship = Ship.new(user_selected_ship[:name],user_selected_ship[:length])
        
    end

    def present_ships(ships_size_limit)
        @available_ships.each do |key,value|
            if value[:length] <= ships_size_limit
                puts "Input: #{key} | Ship: #{value[:name].capitalize}\t| Length: #{value[:length]}"
            end
        end
    end

end