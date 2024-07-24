class Board
    attr_reader :cells, :ships, :end_column, :end_row

    def initialize(end_row = "D", end_column = 4)
       @cells = Hash.new("na")
       @end_row = end_row
       @end_column = end_column.to_i
       @ships = []
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
            return true if cell.coordinate == coord
        end
        false
    end

    def valid_coordinates?(coordinates)
        coordinates.each do |coordinate|
            return false if !valid_coordinate?(coordinate)
        end
        true
    end

    def valid_placement?(ship, coordinates)
        match_length?(ship, coordinates) && valid_coordinates?(coordinates) && straight_line(coordinates) && !overlap?(coordinates)
      end
      
    def match_length?(ship, coordinates)
        ship.length == coordinates.length
    end

    def straight_line(coordinates)
        rows = []
        columns = []
        coordinates.each do |coordinate|
            rows << coordinate[0]
            columns << coordinate[1]
        end
        return column_consecutive?(columns) if rows.uniq.count == 1
        return row_consecutive?(rows) if columns.uniq.count == 1
        false
    end

    def row_consecutive?(row)
        ord_letters = row.map { |letter| letter.ord}
        ord_letters_sort = ord_letters.sort
        return ord_letters_sort == (ord_letters_sort.first .. ord_letters_sort.last).to_a
    end

    def column_consecutive?(column)
        int_nums = column.map { |num| num.to_i}
        int_nums_sort = int_nums.sort
        return int_nums_sort == (int_nums_sort.first .. int_nums_sort.last).to_a
    end
        
    def overlap?(coordinates)
        coordinates.any? { |coordinate| !@cells[coordinate].empty? }
    end

    def place(ship, coordinates)
        if valid_placement?(ship, coordinates)
            @ships << ship
            coordinates.each do |coordinate|
                @cells[coordinate].place_ship(ship)
            end
        end
        false

    end

    def render_column_title
        grid_column_tittle = " "
        (1 .. @end_column).to_a.each do |num|
            grid_column_tittle += " #{num}"
        end
        grid_column_tittle
    end

    def render_body(toggle = false)
        grid_body = ""
        ("A" .. @end_row).to_a.each do |letter|
            grid_body += "\n#{letter}"
            (1 .. @end_column).to_a.each do |num|
                coordinate = "#{letter}#{num}"
                grid_body += " #{@cells[coordinate].render(toggle)}"
            end
        end
        grid_body
    end

    def render(toggle = false)
        render_column_title + render_body(toggle)
    end

end