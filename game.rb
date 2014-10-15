require_relative 'board'
#require_relative 'piece'
require_relative 'pawn'
require_relative 'slidingpiece'
require_relative 'steppingpiece'
require 'colorize'
require 'io/console'

class Game
  attr_reader :board
  def initialize
    @board = Board.new
  end
  
  def play
    system("clear")
    until over?
      board.display
      @board.execute_move(get_input)
    end
  end
  
  def get_input
    start_pos = nil
    end_pos = nil
    until start_pos && end_pos
      board.display
      key = $stdin.getch
      system("clear")

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
        if start_pos.nil? && end_pos.nil?
          start_pos = @board.cursor_position.dup if start_pos.nil?
          p @board.grid[start_pos[0]][start_pos[1]].moves
        else
          end_pos = @board.cursor_position.dup if end_pos.nil? && start_pos
        end
      end
  end
  
  [start_pos, end_pos]
end
  
  def over?
  end
end