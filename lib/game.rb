class Game
  attr_reader :player_hand, :dealer_hand

  def initialize
    @deck = Deck.new
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    2.times { @player_hand.hit!(@deck) }
    2.times { @dealer_hand.hit!(@deck) }
  end

  def hit
    @player_hand.hit!(@deck)
  end

  def stand
    @dealer_hand.play_as_dealer(@deck)
    @winner = determine_winner(@player_hand.value, @dealer_hand.value)
  end

  def status
    { player_cards: @player_hand.cards,
      player_value: @player_hand.value,
      dealer_cards: @dealer_hand.cards,
      dealer_value: @dealer_hand.value,
      winner: @winner }
  end

  def determine_winner(player_value, dealer_value)
    return :dealer if player_value > 21

    return :player if dealer_value > 21
    if player_value == dealer_value
      :push
    elsif player_value > dealer_value
      :player
    else
      :dealer
    end
  end

  def inspect
    status
  end
end
