
class Game

  def initialize
    @deck = Deck.new
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    2.times { @player_hand.hit!(@deck) }
    2.times { @dealer_hand.hit!(@deck) }
  end

end

describe Game do
  it "should have a players hand" do
    Game.new.players_hand.cards.length.should eq(2)
  end
  it "should have a dealers hand"
  it "should have a status"
end