class SteppingPiece < Piece
  attr_reader :pos
  
  def moves
    move_arr = []
    move_dirs.each do |delta|
      new_pos = get_new_pos(@pos, delta)
      if @board.in_board?(new_pos) 
        if !@board.occupied?(new_pos) || enemy?(@board[new_pos])
          move_arr << new_pos
        end
      end
    end
    
    move_arr
  end
end