# In tictactoe two players, one using x, one using o, mark 1 of 9 squares on a board.  
# if one of the players owns 3 squares in a row they win the game.
    
class Player
  attr_reader :marker, :name
  
  def initialize(marker)
    @marker = marker
  end
  
  def winner?(claimed_squares)
    not_empty_wins = Board::WINNING_ARRAYS.select do |a|
                      [claimed_squares[a[0]], claimed_squares[a[1]], claimed_squares[a[2]]] == [@marker, @marker, @marker]
                    end
    !not_empty_wins.empty?
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
  
  def pick_square(squares)
    begin 
    puts "Please choose an empty square using the number 1-9"
    chosen_square = gets.chomp.to_i
    end until squares[chosen_square] == '_'
    chosen_square
  end
end

class Computer < Player
  def pick_square(squares)
    begin
      computer_square = squares.keys.sample
    end until squares[computer_square] == "_"
    computer_square
  end
end

class Board
  WINNING_ARRAYS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  
  def initialize
  end
  
  def draw_board(claimed_squares)
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

class Square
end

class Game
  attr_reader :player, :computer 
  attr_accessor :claimed_squares, :board
    
  def initialize
    @player   = Human.new("X")
    @computer = Computer.new("O")
    @claimed_squares = {1 => "_", 2 => "_", 3 => "_", 4 => "_", 5 => "_", 6 => "_", 7 => "_", 8 => "_", 9 => "_"}
    @board = Board.new
  end
  
  def play
    loop do
      board.draw_board(@claimed_squares)
      claimed_squares[player.pick_square(claimed_squares)] = player.marker
      board.draw_board(@claimed_squares)
      player.check_for_finished_game(@claimed_squares)
      claimed_squares[computer.pick_square(claimed_squares)] = computer.marker
      computer.check_for_finished_game(@claimed_squares)
    end
  end
end

game = Game.new.play