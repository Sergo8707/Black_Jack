class Deck
  attr_reader :cards

  def initialize
    @cards = Deck.build_cards
  end

  def self.build_cards
    cards = []
    [:clubs, :diamonds, :spades, :hearts].each do |suit|
      (2..10).each do |number|
        cards << Card.new(suit, number)
      end
      %w(J Q K A).each do |facecard|
        cards << Card.new(suit, facecard)
      end
    end
    cards.shuffle
  end
end
