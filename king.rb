class King < SteppingPiece
  def move_dirs
    ORTHOGONALS + DIAGONALS
  end
  
  def mark
    @color == :black ? "\u265a".encode('utf-8') : "\u2654".encode('utf-8')
  end
end