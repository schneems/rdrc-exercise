Deck = [2,3,4,5,6,7,8,9,10, :jack, :queen, :king, :ace]
class Game
  attr_accessor :player_hand, :dealer_hand
  def initialize
    @dealer_hand = Hand.new
    @player_hand = Hand.new    
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

game = Game.new
pp game.player_hand
puts "hit? y/n"
answer = gets.chomp
game.player_hand.hit if answer.match(/y/i)

puts game.player_hand.score
