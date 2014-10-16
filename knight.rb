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