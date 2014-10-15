require_relative 'piece'

class SteppingPiece < Piece
  attr_reader :pos
  
  def moves
    move_arr = []
    move_dirs.each do |delta|
      new_pos = pos.map.with_index {|x,i| x + delta[i]}
      if @board.in_board?(new_pos) 
        if !@board.occupied?(new_pos) || enemy?(@board.who_occupies(new_pos))
          move_arr << new_pos
        end
      end
    end
    
    move_arr
  end
end

class King < SteppingPiece
  def move_dirs
    ORTHOGONALS + DIAGONALS
  end
  
  def mark
    @color == :black ? "\u265a".encode('utf-8') : "\u2654".encode('utf-8')
  end
end

class Knight < SteppingPiece
  
  KNIGHT_DIRS = [
    [1 ,2],
    [2, 1],
    [1, -2],
    [2, -1],
    [-1 ,2],
    [-2, 1],
    [-2, -1],
    [-1, -2]
  ]
  def move_dirs
    KNIGHT_DIRS
  end
  
  def mark
    @color == :black ? "\u265e".encode('utf-8') : "\u2658".encode('utf-8')
  end
end