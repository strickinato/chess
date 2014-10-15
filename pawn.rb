require_relative 'piece'

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
    super(board, pos, color)
    @init_pos = pos
  end
  
  def moves
    move_dirs = DELTAS
    attack_dirs = ATTACK_DELTAS
    if @color == :white
      move_dirs = DELTAS.map {|offset| [offset.first * -1, offset.last]}
      attack_dirs = ATTACK_DELTAS.map {|offset| [offset.first * -1, offset.last]} 
    end
    moves = []
    
    #One forward
    new_pos = [(@pos.first + move_dirs[0].first),(@pos.last + move_dirs[0].last)]
    if !@board.occupied?(new_pos)
      moves << new_pos
    
    
      #Two forward
      new_pos = [(@pos.first + move_dirs[1].first),(@pos.last + move_dirs[1].last)] 
      if first_move? && !@board.occupied?(new_pos)
        moves << new_pos
      end
    end
    
    #Attack
    attack_dirs.each do |delta|
      new_pos = pos.map.with_index {|x,i| x + delta[i]}
      moves << new_pos if attack_position_has_enemy?(new_pos)
    end    
    
    moves
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