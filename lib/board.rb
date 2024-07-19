class Board
    attr_reader :cells

    def initialize
       @cells = Hash.new("na")
       new_board
    end

    def valid_coordinate?(coord)
        @cells.find do |coordinate, cell|
            if cell.coordinate == coord
                return true
            end
            false
        end
        false
        # @cells.find {|cell| cell.coordinate == coord ? true : false}
    end

    def new_board(end_row = "D",end_column = 4)
        ("A"..end_row).to_a.each do |letter|
            (1..end_column).to_a.each do |num|
                coordinate = "#{letter}#{num}"
                @cells["#{coordinate}"] = Cell.new(coordinate)
            end
        end
    end
end