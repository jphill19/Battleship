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
        return false if !match_length?(ship,coordinates)
        return false if !valid_coordinates?(coordinates)
        line = straight_line(coordinates)
        return false if !line
        return false if !consecutive_check?(line)
        return false if overlap?(coordinates)
        true
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
        if rows.uniq.count == 1
            return {"columns" =>  columns}
        elsif columns.uniq.count == 1
            return {"rows" => rows}
        else
            return false
        end
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

    def consecutive_check?(line)
        if line.class == Hash
            if line.keys[0] == "rows"
                return row_consecutive?(line["rows"]) 
            elsif line.keys[0] == "columns"
                return column_consecutive?(line["columns"])
            else
                false
            end
        else
            false
        end
    end
        
    def overlap?(coordinates)
        coordinates.each do |coordinate|
            return true if !@cells[coordinate].empty?
        end
        false
    end

    def place(ship, coordinates)
        if valid_placement?(ship, coordinates)
            coordinates.each do |coordinate|
                @cells[coordinate].place_ship(ship)
            end
        end
        false

    end

end