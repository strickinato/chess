require_relative 'piece'
require 'colorize'

class Board
  attr_reader :grid, :cursor_position
  def initialize
    @grid = Array.new(8) do |row|
      Array.new(8)
    end
    @cursor_position = [0,0]
    
    generate_grid
  end
  
  def in_board?(pos)
    pos.all?{|index| (0...8).cover?(index)}
  end
  
  def occupied?(pos)
    #return true of position is occupied
    row, col = pos
    !@grid[row][col].nil?
  end

  def who_occupies(pos)
    row, col = pos
    @grid[row][col]
  end
  
  def in_check?(color)
    king_pos = nil
    
    @grid.each do |row|
      row.each do |piece|
        if piece.is_a?(King) && piece.color == color
          king_pos = piece.pos
        end
      end
    end
    
    @grid.any? do |row|
      row.any? do |piece|
        if !piece.nil? && piece.color != color
          piece.moves.include?(king_pos)
        end
      end
    end
  end
  
  def execute_move(pos)
    start_move, end_move = pos
    
    s_row, s_col = start_move
    e_row, e_col = end_move
    
    piece = @grid[s_row][s_col]
    #if piece.moves.include?(end_move) 
      @grid[e_row][e_col] = piece 
      @grid[s_row][s_col] = nil
      #end
      
  end
      
  
  def display
    rowc, colc = @cursor_position
    @grid.each.with_index do |row, rowi|
      puts
      row.each_with_index do |piece, coli|
        if rowi == rowc && coli == colc        
          unless piece.nil?
            print (piece.mark + " ").white.on_black
          else
            print ('_' + " ").white.on_black
          end
        else
          unless piece.nil?
            print piece.mark + " "
          else
            print '_' + " "
          end
        end
      end
    end
    puts
  end
  
  #put all the pieces in later
  def generate_grid
    @grid[0][0] = Rook.new(self, [0,0], :black)
    @grid[0][7] = Rook.new(self, [0,7], :black)
    @grid[7][0] = Rook.new(self, [7,0], :white)
    @grid[7][7] = Rook.new(self, [7,7], :white)
    @grid[0][1] = Knight.new(self, [0,1], :black)
    @grid[0][6] = Knight.new(self, [0,6], :black)
    @grid[7][1] = Knight.new(self, [7,1], :white)
    @grid[7][6] = Knight.new(self, [7,6], :white)
    @grid[0][2] = Bishop.new(self, [0,2], :black)
    @grid[0][5] = Bishop.new(self, [0,5], :black)
    @grid[7][2] = Bishop.new(self, [7,2], :white)
    @grid[7][5] = Bishop.new(self, [7,5], :white)
    @grid[7][4] = King.new(self, [7,4], :white)
    @grid[0][4] = King.new(self, [0,4], :black)
    @grid[7][3] = Queen.new(self, [7,3], :white)
    @grid[0][3] = Queen.new(self, [0,3], :black)
    @grid[1].map!.with_index do |space, index| 
      space = Pawn.new(self,[1,index], :black)
    end
    @grid[6].map!.with_index do |space, index|
      space = Pawn.new(self,[6,index], :white)
    end
    
  end
  
end