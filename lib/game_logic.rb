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

    end

    def ask_user_for_ships
        ships_selected = []
        puts "Select which ships should be used for your battle!"
        display_users_selected_ships(ships_selected)
        present_ships



    end

    def display_users_selected_ships(ships_selected)
        user_ships_feedback = "Current Ships in your fleat:"
        ships_selected.each do |ship|
            user_ships_feedback += ", #{ship[:name]}"
        end
        puts user_ships_feedback
    end

    def present_ships
        @available_ships.each do |key,value|
            puts "Input: #{key} | Ship: #{value[:name].capitalize}\t| Length: #{value[:length]}"
        end
    end
end