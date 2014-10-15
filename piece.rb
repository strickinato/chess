require_relative 'board'

class Piece
  ORTHOGONALS = [
    [0 ,1],
    [1, 0],
    [0, -1],
    [-1, 0]
  ]
  
  DIAGONALS = [
    [1 ,1],
    [1, -1],
    [-1, -1],
    [-1, 1]
  ]
  
  attr_reader :pos, :color
  
  def initialize(board, pos, color)
    @pos = pos
    @board = board
    @color = color
  end
    
  
  def moves
  end
  
  def enemy?(other_piece)
    @color != other_piece.color
  end

  
end