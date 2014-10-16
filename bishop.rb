class Bishop < SlidingPiece 
  def move_dirs
    DIAGONALS
  end
  
  def mark
    @color == :black ? "\u265d".encode('utf-8') : "\u2657".encode('utf-8')
  end
end