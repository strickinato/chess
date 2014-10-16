class MoveError < StandardError
end
class WrongPlayerError < RuntimeError
end
class Game
  attr_reader :board, :current_color
  # attr_accessor :turn_done
  
  def initialize
    @board = Board.new
  end
  
  def play
    system("clear")
    @current_color = :white
    until over?
      get_input
      switch_player
    end
  end
  
  def get_input
    start_pos, end_pos = nil
    begin
      until start_pos && end_pos
        puts "#{ @current_color.to_s.capitalize }'s Turn"
        board.display
        key = $stdin.getch
        case key
        when 'q'
          exit
        when 'w'
          board.cursor_position[0] -= 1
        when 'a'
          board.cursor_position[1] -= 1
        when 's'
          board.cursor_position[0] += 1
        when 'd'
          board.cursor_position[1] += 1
        when " "
          start_pos, end_pos = select_piece(start_pos, end_pos)
        end
        system("clear")
      end
      
      @board.move(start_pos, end_pos)
      
    rescue MoveError => e
      puts e
      end_pos = nil
      retry
    rescue WrongPlayerError => error
    end
  end
  
  def piece_selected?
    !!@board.selected_position
  end
  
  def select_piece(start_pos, end_pos)
    piece = get_piece_at_cursor
    
    if !piece_selected? && piece
      if piece.color == @current_color
        start_pos = select_piece_at_cursor   
      else
        raise WrongPlayerError.new "not your turn"
      end
      #select start piece
    else
      if start_pos == @board.cursor_position.dup
        #unselect a piece
        start_pos = unselect_piece_at_cursor
      elsif piece_selected?
        #here we are selecting the ending position
        end_pos = select_end_position_from_cursor
      end
    end
    # self.turn_done = false if start_pos.nil?
    [start_pos, end_pos]
  end
  
  def get_piece_at_cursor
    @board[@board.cursor_position]
  end
  
  def select_piece_at_cursor
    pos = @board.cursor_position.dup
    @board.selected_position = @board.cursor_position.dup
    pos
  end
  
  def unselect_piece_at_cursor
    pos = nil
    @board.selected_position = nil
    pos
  end
  
  def select_end_position_from_cursor
    pos = @board.cursor_position.dup
    # self.turn_done = true
    @board.selected_position = nil
    pos
  end
  
  
  def switch_player
    @current_color = (@current_color == :white ?  :black : :white)
  end
  
  def over?
    if  @board.checkmate?(:black) || @board.checkmate?(:white)
      p "CHECKMATE"
    end
  end
end
