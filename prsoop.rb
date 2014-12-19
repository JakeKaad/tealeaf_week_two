# Two players choose paper rock or scissors.  Each choice beats one choice and loses to another.

class Player
  attr_accessor :name, :choice
  
  def initialize(name)
    if name == "player" 
      puts "What is your name?" 
      @name = gets.chomp
    else
      @name = name
    end
    @choice = nil
  end
  
  def picks_hand
    loop do
      puts "#{name}, please choose paper, rock or scissors by typing ( P / R / S )"
      self.choice = gets.chomp
    break if Game::CHOICES.keys.include?(choice)
    end
  end
  
  def computer_picks_hand
    self.choice = Game::CHOICES.keys.sample
  end
  
  def to_s
    "#{name} chose #{Game::CHOICES[choice]}"
  end
  
  def again?
    puts "#{name}, would you like to play again?( Y / N )"
    yes_or_no = gets.chomp.downcase
    yes_or_no == "y"
  end
  
end

class Game
  attr_accessor :computer, :player
  CHOICES = {"p" => "Paper", "r" => "Rock", "s" => "Scissors"}
  OUTCOMES = ["Paper Covers Rock! ", "Rock Crushes Scissors! ", "Scissors Cuts paper! ", "You win!", "You Lose!"]
  
  def initialize
    @player = Player.new("player")
    @computer = Player.new("computer")
  end
  
  def proper_selection?(c)
    CHOICES.include?(c)
  end
  
  def tie?
    puts "Its a tie, throw em again!" if computer.choice == player.choice
    computer.choice == player.choice
  end
  
  def win_or_lose(player_choice, computer_choice)
    case
      when player_choice == "p" && computer_choice == "r"
      OUTCOMES[0] + OUTCOMES[3]
      when player_choice == "p" && computer_choice == "s"
      OUTCOMES[2] + OUTCOMES[4]
      when player_choice == "r" && computer_choice == "p"
      OUTCOMES[0] + OUTCOMES[4]
      when player_choice == "r" && computer_choice == "s"
      OUTCOMES[1] + OUTCOMES[3]
      when player_choice == "s" && computer_choice == "p"
      OUTCOMES[2] + OUTCOMES[3]
      when player_choice == "s" && computer_choice == "r"
      OUTCOMES[1] + OUTCOMES[4]
    end
  end
    
  def play
    begin
      begin
        begin
        end while proper_selection?(player.picks_hand)
        computer.computer_picks_hand
        puts player; puts computer
      end while tie?
      puts player.choice
      puts win_or_lose(player.choice, computer.choice)
    end while player.again?
  end

end

game = Game.new.play
