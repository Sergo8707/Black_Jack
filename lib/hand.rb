class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def hit!(deck)
    @cards << deck.cards.pop
  end

  def value
    value = 0
    cards.each do |card|
      value += card.value
    end
    value
  end
end
