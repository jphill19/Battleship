class Board
    attr_reader :cells

    def initialize(end_row = "D", end_column = 4)
       @cells = Hash.new("na")
       @end_row = end_row
       @end_column = end_column
       new_board
    end

    def new_board(end_row = @end_row,end_column = @end_column)
        ("A"..end_row).to_a.each do |letter|
            (1..end_column).to_a.each do |num|
                coordinate = "#{letter}#{num}"
                @cells["#{coordinate}"] = Cell.new(coordinate)
            end
        end
    end    
    
    def valid_coordinate?(coord)
        @cells.find do |coordinate, cell|
            if cell.coordinate == coord
                return true
            end
        end
        false
        # @cells.find {|cell| cell.coordinate == coord ? true : false}
    end

    def valid_placement?(ship, coordinates)
        
    end

    def match_length?(ship, coordinates)
        ship.length == coordinates.length
    end

    def straight_line(coordinates)
    end

    def consecutive_check?(coordinates)
        
    end
        
end