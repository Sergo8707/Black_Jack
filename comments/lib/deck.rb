require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = build_cards
  end

  protected

  def build_cards
    cards = []
    %w(♠ ♣ ♥ ♦).each do |suit|
      (2..10).each do |number|
        cards << Card.new(suit, number)
      end
      %w(A K Q J).each do |facecard|
        cards << Card.new(suit, facecard)
      end
    end
    cards.shuffle!
  end
end
