require 'rspec'

require_relative '../lib/card'
require_relative '../lib/deck'
require_relative '../lib/game'
require_relative '../lib/hand'

describe Card do
  it 'should accept suit and value when building' do
    card = Card.new(:clubs, 10)
    card.suit.should eq(:clubs)
    card.value.should eq(10)
  end

  it 'should have a value of 10 for facecards' do
    facecards = %w(J Q K)
    facecards.each do |facecard|
      card = Card.new(:hearts, facecard)
      card.value.should eq(10)
    end
  end

  it 'should have a value of 4 for the 4-clubs' do
    card = Card.new(:clubs, 4)
    card.value.should eq(4)
  end

  it 'should return 11 for Ace' do
    card = Card.new(:diamonds, 'A')
    card.value.should eq(11)
  end

  it 'should be formatted nicely' do
    card = Card.new(:diamonds, 'A')
    card.to_s.should eq('A-diamonds')
  end
end

describe Deck do
  it 'should build 52 cards' do
    Deck.build_cards.length.should eq(52)
  end

  it 'should have 52 cards when new deck' do
    Deck.new.cards.length.should eq(52)
  end
end

describe Hand do
  it 'should calculate the value correctly' do
    deck = double(:deck, cards: [Card.new(:clubs, 4), Card.new(:diamonds, 10)])
    hand = Hand.new
    2.times { hand.hit!(deck) }
    hand.value.should eq(14)
  end

  it 'should take from the top of the deck' do
    club4 = Card.new(:clubs, 4)
    diamond7 = Card.new(:diamonds, 7)
    clubK = Card.new(:clubs, 'K')

    deck = double(:deck, cards: [club4, diamond7, clubK])
    hand = Hand.new
    2.times { hand.hit!(deck) }
    hand.cards.should eq([club4, diamond7])
  end

  describe '#play_as_dealer' do
    it 'should hit blow 16' do
      deck = double(:deck, cards: [Card.new(:clubs, 4), Card.new(:diamonds, 4), Card.new(:clubs, 2), Card.new(:hearts, 6)])
      hand = Hand.new
      2.times { hand.hit!(deck) }
      hand.play_as_dealer(deck)
      hand.value.should eq(16)
    end
    it 'should not hit above' do
      deck = double(:deck, cards: [Card.new(:clubs, 8), Card.new(:diamonds, 9)])
      hand = Hand.new
      2.times { hand.hit!(deck) }
      hand.play_as_dealer(deck)
      hand.value.should eq(17)
    end
    it 'should stop on 21' do
      deck = double(:deck, cards: [Card.new(:clubs, 4),
                                   Card.new(:diamonds, 7),
                                   Card.new(:clubs, 'K')])
      hand = Hand.new
      2.times { hand.hit!(deck) }
      hand.play_as_dealer(deck)
      hand.value.should eq(21)
    end
  end
end

describe Game do
  it 'should have a players hand' do
    Game.new.player_hand.cards.length.should eq(2)
  end
  it 'should have a dealers hand' do
    Game.new.dealer_hand.cards.length.should eq(2)
  end
  it 'should have a status' do
    Game.new.status.should_not be_nil
  end
  it 'should hit when I tell it to' do
    game = Game.new
    game.hit
    game.player_hand.cards.length.should eq(3)
  end
  it 'should play the dealer hand when I stand' do
    game = Game.new
    game.stand
    game.status[:winner].should_not be_nil
  end

  describe '#determine_winner' do
    it 'should have dealer win when player busts' do
      Game.new.determine_winner(22, 15).should eq(:dealer)
    end
    it 'should player win if dealer busts' do
      Game.new.determine_winner(18, 22).should eq(:player)
    end
    it 'should have player win if player > dealer' do
      Game.new.determine_winner(18, 16).should eq(:player)
    end
    it 'should have push if tie' do
      Game.new.determine_winner(16, 16).should eq(:push)
    end
  end
end
