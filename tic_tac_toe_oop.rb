# In tictactoe two players, one using x, one using o, mark 1 of 9 squares on a board.  
# if one of the players owns 3 squares in a row they win the game.
require 'pry'
class Player
  attr_reader :marker, :name
  WINNING_ARRAYS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  
  def initialize(marker)
    @marker = marker
  end
  
  def winner?(claimed_squares)
    not_empty_wins = WINNING_ARRAYS.select do |a|
                      [claimed_squares[a[0]], claimed_squares[a[1]], claimed_squares[a[2]]] == [@marker, @marker, @marker]
                    end
    not_empty_wins.any?
  end
  
  def tie?(claimed_squares)
    !claimed_squares.values.include?("_")
  end
  
  def check_for_finished_game(claimed_squares)
    if winner?(claimed_squares)
      puts "The game is over."
      puts "#{name} won!"
      exit
    elsif tie?(claimed_squares)
      puts "The game is a Stalemate!"
      exit
    end
  end
end

class Human < Player
  def initialize(marker)
    puts "What is your name?"
    @name = gets.chomp
    super(marker)
  end
  
  def pick_square(claimed_squares)
    begin 
    puts "Please choose an empty square using the number 1-9"
    chosen_square = gets.chomp.to_i
    end until claimed_squares[chosen_square] == '_'
    chosen_square
  end
end

class Computer < Player
  
  def initialize(marker)
    @name = "Computer"
    super(marker)
  end
  

  def pick_square(claimed_squares, player)
    begin
        if two_in_a_row(claimed_squares).is_a?(Integer)
          computer_square = two_in_a_row(claimed_squares)
        else
          computer_square = claimed_squares.keys.sample
        end
    end until claimed_squares[computer_square] == "_"
    computer_square
  end
  
  def two_in_a_row(claimed_squares)
    two_in_array = WINNING_ARRAYS.select do |a|
                      [claimed_squares[a[0]], claimed_squares[a[1]], claimed_squares[a[2]]].sort == ["X", "X", "_"]
                  end
    two_in_array.flatten.select do |n|
      claimed_squares[n] == "_"
    end.pop
  end
  
end

class Board
  
  def clear_screen
    system 'clear'
  end

  def draw_board(claimed_squares)
    clear_screen
    puts "    |    |    "
    puts " #{claimed_squares[1]}  | #{claimed_squares[2]}  | #{claimed_squares[3]} "
    puts "____|____|____"
    puts "    |    |    " 
    puts " #{claimed_squares[4]}  | #{claimed_squares[5]}  | #{claimed_squares[6]}  "
    puts "____|____|____"
    puts "    |    |    "
    puts " #{claimed_squares[7]}  | #{claimed_squares[8]}  | #{claimed_squares[9]}  "
    puts "    |    |    "
  end
end

class Game
  attr_reader :player, :computer 
  attr_accessor :claimed_squares, :board
    
  def initialize
    @player   = Human.new("X")
    @computer = Computer.new("O")
    @claimed_squares = {1 => "_", 2 => "_", 3 => "_", 4 => "_", 5 => "_", 6 => "_", 7 => "_", 8 => "_", 9 => "_"}
    @board = Board.new
    @current_player = @player
  end
  
  def play
    loop do
      board.draw_board(@claimed_squares)
      claimed_squares[player.pick_square(claimed_squares)] = player.marker
      board.draw_board(@claimed_squares)
      player.check_for_finished_game(@claimed_squares)
      claimed_squares[computer.pick_square(claimed_squares, player)] = computer.marker
      board.draw_board(@claimed_squares)
      computer.check_for_finished_game(@claimed_squares)
    end
  end
end

game = Game.new.play