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
  
  attr_reader :color
  attr_accessor :pos
  
  def initialize(board, pos, color)
    @pos = pos
    @board = board
    @color = color
  end
  
  def get_new_pos(pos, offset)
    [(pos.first + offset.first), (pos.last + offset.last)]
  end
  
  def moves_into_check?(pos)
    duped_board = @board.deep_dup 
    duped_board[self.pos].move!(pos)
    duped_board.in_check?(self.color)
  end
  
  def move(destination)
    #use valid moves here?
    
    if self.moves.include?(destination)
      if !self.moves_into_check?(destination)
        move!(destination)
      else
        raise MoveError.new "illegal to move into check"
      end
    else
      raise MoveError.new "not a real move"
    end
  end
  
  def valid_moves
    self.moves.select { |move| !moves_into_check?(move) } 
  end
  
  def move!(destination)
    if self.moves.include?(destination)      
      @board[destination] = self
      @board[@pos] = nil
      @pos = destination
    end
  end
  
  def moves
  end
  
  def enemy?(other_piece)
    @color != other_piece.color
  end
end