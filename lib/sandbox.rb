
require './lib/game_logic'
require './lib/computer_brain2'


ship = Ship.new('cruiser',3)

board = Board.new("D",5)

board.place(ship, ['A1', 'A2', 'A3'])


puts board.render(true)

puts 