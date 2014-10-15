# require_relative 'board'
# require_relative 'piece'
# require_relative 'pawn'
# require_relative 'slidingpiece'
# require_relative 'steppingpiece'
#
# b = Board.new
# b.display
#
# test = Bishop.new(b, [4,1], :black)
# b.grid[4][1] = test
#
#
# b.display
# p b.in_check?(:white)
# p test.moves

require_relative 'game'

g = Game.new
g.play