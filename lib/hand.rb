class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def hit!(deck)
    @cards << deck.cards.shift
  end

  def value
    cards.inject(0) { |sum, card| sum += card.value }
  end

  def play_as_dealer(deck)
    if value < 16
      hit!(deck)
      play_as_dealer(deck)
    end
  end
end
