class Deck
  attr_accessor :cards
  CARD_VALUES = (2..10).to_a << "Jack" << "Queen" << "King" << "Ace"
  SUITS = ["Spades", "Clubs", "Hearts", "Diamonds"]

  def initialize
    @cards = CARD_VALUES.product(SUITS).each {|card| card  = Card.new(card[0], card[1]) }
  end
  
  def shuffle
    @cards.shuffle!
  end
  
  def deal
    @cards.pop
  end
end

class Card
  attr_reader :value, :suit
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end


class Player
  attr_accessor :hand, :total, :name
  
  def initialize(name)
    @name = name
    @hand = []
    @total = 0
  end
  
  def display_hand(hand)
    puts "#{name}'s hand is #{hand.map { |card| "#{card[0]} of #{card[1]}" }.join(", ")}"
    puts "with a total of #{total}"
  end
  
  def blackjack?(hand)
    hand.size == 2 && total == 21
  end
  
  def bust?
    total > 21
  end
end

class Human < Player
  
  def hit_or_stay?(dealer_hand)
      begin
        system 'clear'
        puts "Dealer is showing: #{dealer_hand}"
        display_hand(hand)
        puts "Would you like to hit or stay?"
        hit_or_stay = gets.chomp.downcase
      end until hit_or_stay == "hit" || hit_or_stay == "stay"
      hit_or_stay
  end
end

class Dealer < Player
  
  def display_dealer_first_card(hand)
    card = hand.first
    "#{card[0]} of #{card[1]}"
  end
  
  def hit_or_stay?
    if total < 17
      return "hit"
    else
      return "stay"
    end
  end
end

class Blackjack
  attr_accessor :deck, :winner
  attr_reader :player, :dealer
  
  def initialize
    @deck = Deck.new
    @dealer = Dealer.new("Dealer")
    @player = Human.new("Player")
    @winner = nil
  end
  
  def calculate_total(hand)
    total = 0
    
    card_values = hand.map { |card| card[0] }
    
    card_values.each do |value|
      if value == "Ace"
        total += 11
      elsif value.to_i == 0
        total += 10
      else
        total += value.to_i
      end
    end
    
    card_values.select{ |val| val == "Ace"}.count.times do
      total -= 10 if total > 21
    end
    total
  end
  
  def update_totals
    player.total = calculate_total(player.hand)
    dealer.total = calculate_total(dealer.hand)
  end
  
  def deal_opening_hands
    deck.shuffle
    player.hand << deck.deal
    dealer.hand << deck.deal
    player.hand << deck.deal
    dealer.hand << deck.deal
    update_totals
  end
  
  def player_turn
    if player.blackjack?(player.hand)
      puts "Congratulations, you hit blackjack, lets see what the dealer has."
      @winner = player.name
    else 
      while player.hit_or_stay?(dealer.display_dealer_first_card(dealer.hand)) == "hit"
        player.hand << deck.deal
        update_totals
        if player.bust?
          puts "You busted with a total of #{player.total}"
          @winner = dealer.name
          break
        end
      end
    end
  end
  
  def dealer_turn
    dealer.display_hand(dealer.hand)
    if dealer.blackjack?(dealer.hand)
      puts "The dealer hit Blackjack!"
      @winner = dealer.name
    else
      until dealer.hit_or_stay? == "stay"
        sleep 1
        system 'clear'
        puts "The dealer hits"
        dealer.hand << deck.deal
        update_totals
        dealer.display_hand(dealer.hand)
        if dealer.bust?
          puts "The dealer busted with a total #{dealer.total}"
          @winner = player.name
          break
        end
      end
    end
  end
  
  def find_the_winner
    if winner == nil
      @winner = player.name if player.total > dealer.total
    end
  end
  
  def display_winner
    system "clear"
    dealer.display_hand(dealer.hand)
    puts "-----------------------------------"
    player.display_hand(player.hand)
    find_the_winner
    if winner == player.name
      puts "The dealer busted!" if dealer.bust?
      puts "Blackjack!" if player.blackjack?(player.hand)
      puts "You win the round!"
    else
      puts "You busted!" if player.bust?
      puts "The dealer hit Blackjack!" if dealer.blackjack?(dealer.hand)
      puts "The dealer wins the round!"
    end
  end
  
  def play_blackjack
    deal_opening_hands
    player_turn
    dealer_turn unless player.bust?
    display_winner
  end
end

class Bank
  
  attr_accessor :balance
  def initialize(deposit)
    @balance = deposit
  end
end

class Engine
  
  attr_accessor :bank, :bet, :game
  def initialize
    @bank = Bank.new(500)
    @bet = 0
    @game = ""
  end
  
  def opening_screen
    say "Welcome to my magnificent game collection"
    say "I have 3 wonderful games for you to play!"
    say "Please Select:"
    say " "
    say "1: Blackjack"
    say "2: Tic-Tac_toe(not yet implemented)"
    say "3: Paper-Rock_Scissors(under construction)"
    say "Any other key to exit"
    say " "
    say "Please select 1, 2 or 3"
    choice = gets.chomp    
    blackjack if choice == "1"
  end
  
  def blackjack
    say "The dealer begins shuffling."
    system 'clear'
    if bank.balance > 0
      begin
      system 'clear'
        say "You have #{bank.balance} dollars.  How much would you like to bet?"
        place_bet
        @game = Blackjack.new
        @game.play_blackjack
        bank.balance += (@bet * 2) if winner?
      end while again?
    else
      puts "You are broke, buh bye!"
    end
  end
  
  def winner?
    @game.winner == "Player"
  end
  
  def again?
    say "would you like to play again? ( Y / N)"
    gets.chomp.downcase == "y"
  end
  
  def place_bet
    @bet = gets.chomp.to_i
    if @bet > bank.balance
      puts "You don't have the much, betting #{bet}"
      @bet = bank.balance
    end
    @bank.balance -= @bet
  end
  
  def say(text)
    puts "<<>> #{text}"
  end
end

start = Engine.new.opening_screen
