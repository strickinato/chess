class Rook < SlidingPiece
  
  def move_dirs
    ORTHOGONALS
  end
  
  def mark
    @color == :black ? "\u265c".encode('utf-8') : "\u2656".encode('utf-8')
  end
end