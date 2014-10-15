require_relative 'piece'

class SlidingPiece < Piece

  attr_reader :pos
  
  def moves
    move_arr = []
    move_dirs.each do |delta|
      new_pos = pos.map.with_index {|x,i| x + delta[i]}
      while true
        break if !@board.in_board?(new_pos)
        if @board.occupied?(new_pos)
          if enemy?(@board.who_occupies(new_pos))
            move_arr << new_pos
            break
          end
          break
        end
        move_arr << new_pos
        new_pos = new_pos.map.with_index {|x,i| x + delta[i]}
      end
    end
      move_arr
  end
  
  
end

class Rook < SlidingPiece
  def move_dirs
    ORTHOGONALS
  end
  
  def mark
    @color == :black ? "\u265c".encode('utf-8') : "\u2656".encode('utf-8')
  end

end

class Bishop < SlidingPiece 
  def move_dirs
    DIAGONALS
  end
  
  def mark
    @color == :black ? "\u265d".encode('utf-8') : "\u2657".encode('utf-8')
  end
end

class Queen < SlidingPiece

  def move_dirs
    DIAGONALS + ORTHOGONALS
  end
  
  def mark
    @color == :black ? "\u265b".encode('utf-8') : "\u2655".encode('utf-8')
  end
  
end