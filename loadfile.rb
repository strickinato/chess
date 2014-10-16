require_relative 'piece'
require_relative 'pawn'
require_relative 'slidingpiece'
require_relative 'steppingpiece'
require_relative 'bishop'
require_relative 'queen'
require_relative 'rook'
require_relative 'board'
require_relative 'knight'
require_relative 'king'
require_relative 'game'
require 'colorize'
require 'io/console'

g = Game.new
g.play