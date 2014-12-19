# Two players choose paper rock or scissors.  Each choice beats one choice and loses to another.

class Player
  attr_accessor :name, :choice
  
  def initialize(n)
    @name = n
    @choice = nil
  end
  
  def choice_prompt
    puts "#{name}, please choose paper, rock or scissors by typing ( P / R / S )"
    gets.chomp
  end
  
   def refine_choice
    @choice = "Paper"    if @choice == "p"
    @choice = "Rock"     if @choice == "r"
    @choice = "Scissors" if @choice == "s"
  end
  
  def to_s
    "#{name} chose #{choice}"
  end
  
  def again?
    puts "#{name}, would you like to play again?( Y / N )"
    yes_or_no = gets.chomp.downcase
    false if yes_or_no == "n"
  end
    

end



class Game
  attr_accessor :computer_choice, :player_choice
  CHOICES = ["p", "r", "s"]
  OUTCOMES = ["Paper Covers Rock!", "Rock Crushes Scissors!", "Scissors Cuts paper!", "You win!", "You Lose!"]
  
  def initialize
    @computer_choice = nil
    @player_choice = nil
  end
  
  
  def proper_selection?(c)
    CHOICES.include?(c)
  end
  
  def computer_chooses
    CHOICES.sample
  end
  
  def name_prompt
    puts "What is your name?"
    gets.chomp
  end
  
  def tie?
    puts "Its a tie, throw em again!" if computer_choice == player_choice
    computer_choice == player_choice
  end
  
  def win_or_lose(pc, cc)
    case
      when pc == "p" && cc =="r"
      OUTCOMES[0] + " " + OUTCOMES[3]
      when pc == "p" && cc == "s"
      OUTCOMES[2] + " " + OUTCOMES[4]
      when pc == "r" && cc == "p"
      OUTCOMES[0] + " " + OUTCOMES[4]
      when pc == "r" && cc == "s"
      OUTCOMES[1] + " " + OUTCOMES[3]
      when pc == "s" && cc == "p"
      OUTCOMES[2] + " " + OUTCOMES[3]
      when pc == "s" && cc == "r"
      OUTCOMES[1] + " " + OUTCOMES[4]
    end
  end
end


game = Game.new
player = Player.new(game.name_prompt)
computer = Player.new("Computer")
begin
  begin
    begin
      player.choice = (game.player_choice = player.choice_prompt.downcase)
    end while !game.proper_selection?(player.choice)
    computer.choice = (game.computer_choice = game.computer_chooses)
  end while game.tie?
  player.refine_choice
  computer.refine_choice
  puts player
  puts computer
  puts game.win_or_lose(game.player_choice, game.computer_choice)
end until player.again?

