require './spec/spec_helper'

board = Board.new
# row = ['A','B','C']
row = {"rows" => ['A','B','C']}
column = {"columns" => ['1','2','3']}

# puts row.keys[0].class

puts board.consecutive_check?(row)
