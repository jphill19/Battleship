class Board
    attr_reader :cells

    def initialize(cells)
        @cells = cells
    end

    def valid_coordinate?(coord)
        @cells.find do |cell|
            if cell.coordinate == coord
                return true
            end
            false
        end
        false
        # @cells.find {|cell| cell.coordinate == coord ? true : false}
    end
end