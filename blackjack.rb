Deck = [2,3,4,5,6,7,8,9,10, :jack, :queen, :king, :ace]
class Game


  attr_accessor :dealer, :players
  def initialize(num_of_players = 1)
    @dealer = Player.new
    @players = num_of_players.times.map { Player.new }
  end
  
  def play_round
    @dealer.play
    @players.each(&:play)
  end
end

class Hand
  attr_accessor :cards
  
  def initialize
    @cards = [Deck.shuffle.first, Deck.shuffle.first]
  end

  def score
    total = 0
    cards.each do |card|
      total += card if card.is_a? Integer
      total += 10 if card == :jack || card == :queen || card == :king
      total += 1 if card == :ace && card + 11 > 21
      total += 11 if card == :ace && card + 11 < 21
    end
    return total
  end
  
  def hit
    self.cards << Deck.shuffle.first
  end
end

require 'pp'

class Player
  attr_accessor :hand

  def initialize(input = STDIN, output = STDOUT)
    @hand = Hand.new 
    @input = input
    @output = output
  end
  
  def play
    @output.puts "Your Score: #{hand.score}. Hit? y/n" 
    answer = @input.gets.chomp
    if answer.match(/y/i)   
      game.player_hand.hit
      @output.puts "Score: #{hand.score}"
      if hand.score > 21
        @output.puts "Busted."
      else
        play
      end
    end
  end
end

game = Game.new
game.play_round
