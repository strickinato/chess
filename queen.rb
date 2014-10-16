class Queen < SlidingPiece

  def move_dirs
    DIAGONALS + ORTHOGONALS
  end
  
  def mark
    @color == :black ? "\u265b".encode('utf-8') : "\u2655".encode('utf-8')
  end
  
end