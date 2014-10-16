class Pawn < Piece
  DELTAS = [
    [1, 0],
    [2, 0]
  ]
  
  ATTACK_DELTAS = [
    [1, -1],
    [1, 1]
  ]
  
  attr_reader :pos, :color
  
  def initialize(board, pos, color)
    super
    @init_pos = pos
  end
  
  def direction
     @color == :white ? -1 : 1
  end
  
  def moves
    moves = []
    
    #One forward
    new_pos = get_new_pos(@pos, move_dirs(direction)[0])
     unless @board.occupied?(new_pos)
      moves << new_pos
    
      #Two forward
      new_pos = get_new_pos(@pos, move_dirs(direction)[1])
      if first_move? && !@board.occupied?(new_pos)
        moves << new_pos
      end
    end
    
    #Attack
    attack_dirs(direction).each do |delta|
      new_pos = get_new_pos(@pos, delta)
      moves << new_pos if attack_position_has_enemy?(new_pos)
    end    
    
    moves
  end
  
  def move_dirs(direction)
    DELTAS.map {|offset| [offset.first * direction, offset.last]}
  end
  
  def attack_dirs(direction)
    ATTACK_DELTAS.map {|offset| [offset.first * direction, offset.last]} 
  end
  
  def first_move?
    @pos == @init_pos
  end
  
  def attack_position_has_enemy?(pos)
    if @board.in_board?(pos) && @board.occupied?(pos)
      enemy?(@board.who_occupies(pos))
    end
  end
  
  def mark
    @color == :black ? "\u265f".encode('utf-8') : "\u2659".encode('utf-8')
  end
end