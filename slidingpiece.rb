class SlidingPiece < Piece

  attr_reader :pos
  
  def moves 
    move_arr = []
    move_dirs.each do |delta|
      new_pos = get_new_pos(@pos, delta)
      while true
        break if !@board.in_board?(new_pos)
        if @board[new_pos]
          if enemy?(@board.who_occupies(new_pos))
            move_arr << new_pos
            break
          end
          break
        end
        move_arr << new_pos
        new_pos = get_new_pos(new_pos, delta)
      end
    end
    move_arr
  end
  
end