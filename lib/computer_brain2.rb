class ComputerBrain


    def initialize(player_board)
        @player_board = player_board

        @available_shots = player_board.keys

        @shots_taken = []

        @current_hits = []
        @directions = [:left, :right, :up, :down]
        @side_directions = [:left, :down]
        @ladder_directions = [:up, :down]
        @current_sinks =0

        @same_col_hits = []
        @rsame_row_hits = []

    end

    def random_shot
        shot = @available_shots.sample
        update_available_shots(shot)
        update_shots_taken(shot)
        check_if_shot_hit(shot)
        return shot
    end

    def update_shots_taken(shot)
        @shots_taken << shot
    end
    
    def update_available_shots(shot)
        @available_shots.delete(shot)
    end

    def check_if_shot_hit(shot)
        puts "\n\n#{@player_board.cells[shot].render}\n\n"
        if @player_board.cells[shot].render == "H"
            @current_hits << shot
            return true
        elsif @player_board.cells[shot].render == 'S'
            delete_sunk_ships(@current_hits)
        end
        false
    end

    def check_if_col_shot_hit(shot)
        if @player_board.cells[shot].render == "H"
            @same_row_hits << shot
            return true
        elsif @player_board.cells[shot].render == 'S'
            delete_sunk_ships(@same_row_hits)
        end
        false
    end


    def check_if_row_shot_hit(shot)
        if @player_board.cells[shot].render == "H"
        @same_col_hits << shot
        return true
        elsif @player_board.cells[shot].render == 'S'
        delete_sunk_ships(@same_col_hits)
        end
        false
    end

    def find_corelation
        rows = []
        columns = []
        @current_hits.each do |coordinate|
            rows << coordinate[0]
            columns << coordinate[1]
        end
        @same_row_hits = @current_hits if rows.uniq.count == 1
        @same_col_hits = @current_hits if columns.uniq.count == 1
        wipe_current_hits
    end

    def wipe_current_hits
        @current_hits = []
    end

    def decide_shot
        return col_shots unless @same_row_hits.empty?
        return row_shots unless @same_col_hits.empty?
        return aimed_shots unless @current_hits.empty?
        random_shot
    end


    def aimed_shots
        @directions.each do |direction|
            shot = aim_in_direction(@current_hits.last, direction)
            next unless shot
            if valid_shot(shot)
                update_available_shots(shot)
                update_shots_taken(shot)
                find_corelation if check_if_shot_hit(shot)
                delete_sunk_ships(@current_hits)
                return shot
            end
        end
        random_shot    
    end

    def aim_in_direction(hit, direction)
        row = hit[0]
        col = hit[1].to_i
    
        case direction
        when :left
          new_col = col - 1
          return "#{row}#{new_col}" if new_col >= 1
        when :right
          new_col = col + 1
          return "#{row}#{new_col}" if new_col <= @player_board.end_column
        when :up
          new_row = (row.ord - 1).chr
          return "#{new_row}#{col}" if new_row >= 'A'
        when :down
          new_row = (row.ord + 1).chr
          return "#{new_row}#{col}" if new_row <= @player_board.end_row
        end
        nil

    def delete_sunk_ships(array)
        array.delete_if { |hit| @player_board.cells[hit].render == 'X' }  
    end
    
    def col_shots
        @same_row_hits.each do |hit|
          @ladder_directions.each do |direction|
            col_shot = aim_in_direction(hit, direction)
            next unless col_shot
            if valid_shot?(col_shot)
              update_available_shots(col_shot)
              update_shots_taken(col_shot)
              check_if_col_shot_hit(col_shot)
              return col_shot
            end
          end
        end
        maybe_ships_are_stacked('row')
      end
    
      def row_shots
        @same_col_hits.each do |hit|
          @side_directions.each do |direction|
            row_shot = aim_in_direction(hit, direction)
            next unless row_shot
            if valid_shot?(row_shot)
              update_available_shots(row_shot)
              update_shots_taken(row_shot)
              check_if_row_shot_hit(row_shot)
              return row_shot
            end
          end
        end
        maybe_ships_are_stacked('col')
      end

    def maybe_ships_are_stacked(toggle_word)
        if toggle_word == 'row'
            @same_col_hits = @same_row_hits
            @same_row_hits = []
            return row_shots
        elsif toggle_word == 'col'
            @same_row_hits = @same_col_hits
            @same_col_hits = []
            return col_shots
        end
    e d

    def valid_shot?(shot)
        return false if @shots_taken.include?(shot)
        return false if shot.chars[0].ord >= 'A'.ord && shot.chars[0].ord <= @player_board.end_row
        return false if shot.chars[1].to_i >= 0 && shot.chars[1].to_i <= @player_board.end_column
        true
    end

end