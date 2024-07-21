require './spec/spec_helper'

board = Board.new
# row = ['A','B','C']
row = {"rows" => ['A','B','C']}
column = {"columns" => ['1','2','3']}

cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)
coordinates = ['A1', 'B1', 'C1']
# puts row.keys[0].class

puts board.valid_placement?(cruiser, coordinates)

