class Board
  attr_reader :grid, :cursor_position
  attr_accessor :selected_position
  
  def initialize(fill = true)
    @grid = Array.new(8) do |row|
      Array.new(8)
    end
    @cursor_position = [7, 0]
    
    generate_grid if fill
  end
  
  def move(start, end_pos)
    #checks validity of move
    #if valid, moves piece
    self[start].move(end_pos)
  end
  def [](pos)
    row, col = pos
    @grid[row][col]
  end
  
  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end
  
  def in_board?(pos)
    pos.all? { |index| (0...8).cover?(index) }
  end
  
  def occupied?(pos)
    !self[pos].nil?
  end

  def who_occupies(pos)
    row, col = pos
    @grid[row][col]
  end
  
  def pieces
    @grid.flatten.compact
  end
  
  def deep_dup
    duped_board = Board.new(false)
    
    pieces.each_with_index do |piece, index|
      duped_piece = piece.class.new(duped_board, piece.pos, piece.color)
      duped_board[piece.pos] = duped_piece
    end
    
    duped_board
  end
  
  def in_check?(color)
    king_pos = nil
    
    pieces.each do |piece|
      #use color_pieces
      if piece.is_a?(King) && piece.color == color
        king_pos = piece.pos
      end
    end
    
    pieces.any? do |piece|
      #use color_pieces
      if piece.color != color
        piece.moves.include?(king_pos)
      end
    end
  end
  
  def color_pieces(color)
    pieces.select { |piece| piece.color == color }
  end
  
  def checkmate?(color)
    in_check?(color) && color_pieces(color).all? do |piece| 
      piece.valid_moves.empty?
    end
  end
  
  def display
    display_string = ""
    @grid.each.with_index do |row, rowi|
      display_string = display_string + "\n"
      row.each_with_index do |piece, coli|
        add_string = (piece ?  "#{piece.mark} " :  "  ")
        
        if [rowi, coli] == @cursor_position
          print add_string.on_blue
        elsif [rowi, coli] == @selected_position
          print add_string.on_red
        elsif (rowi + coli).even?
          print add_string.on_green
        else
          print add_string.on_white
        end
      end 
      print "\n"    
    end
    display_string = display_string + "\n"
  end
  
  
  def generate_grid
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    place_pieces(back_row, 0, :black)
    place_pieces(back_row, 7, :white)
    pawns = Array.new(8, Pawn)
    place_pieces(pawns, 1, :black)
    place_pieces(pawns, 6, :white)
  end
  
  def place_pieces(pieces_order, row, color)
    pieces_order.each_with_index do |klass, col|       
      self[[row, col]] = klass.new(self, [row, col], color)
    end
  end
end