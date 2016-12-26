require 'rspec'

require_relative '../lib/card'
require_relative '../lib/deck'
require_relative '../lib/game'
require_relative '../lib/hand'

describe Card do

  it "should accept suit and value when building" do
    card = Card.new(:clubs, 10)
    card.suit.should eq(:clubs)
    card.value.should eq(10)
  end

  it "should have a value of 10 for facecards" do
    facecards = ["J", "Q", "K"]
    facecards.each do |facecard|
      card = Card.new(:hearts, facecard)
      card.value.should eq(10)
    end
  end

  it "should have a value of 4 for the 4-clubs" do
    card = Card.new(:clubs, 4)
    card.value.should eq(4)
  end

  it "should return 11 for Ace" do
    card = Card.new(:diamonds, "A")
    card.value.should eq(11)
  end

  it "should be formatted nicely" do
    card = Card.new(:diamonds, "A")
    card.to_s.should eq("A-diamonds")
  end
end

describe Deck do

  it "should build 52 cards" do
    Deck.build_cards.length.should eq(52)
  end

  it "should have 52 cards when new deck" do
    Deck.new.cards.length.should eq(52)
  end
end

describe Game do
  it "should have a players hand" do
    Game.new.player_hand.cards.length.should eq(2)
  end
  it "should have a dealers hand" do
    Game.new.dealer_hand.cards.length.should eq(2)
  end
  it "should have a status" do
    Game.new.status.should_not be_nil
  end
end


describe Hand do

  it "should calculate the value correctly" do
    mock_cards = [Card.new(:clubs, 5), Card.new(:diamonds, 10)]
    hand = Hand.new
    hand.stub(:cards) { mock_cards}
    hand.value.should eq(15)
  end
end

