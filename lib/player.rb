require_relative 'hand'

class Player
  attr_accessor :cards, :name, :money
  include Hand

  def initialize(name, money)
    @name = name
    @money = money
    @cards = []
  end

  def rate(rate)
    raise 'У вас закончились деньги' if rate > money || money.zero?
    @money -= rate
  end

  def win(rate)
    @money += rate
  end

  def total_cards
    cards.size
  end

  def show_cards
    if name != 'Дилер'
      puts "#{name} cards: #{cards * ' '}"
    else
      puts "#{name} cards: #{cards.collect { |_card| _card = '*' } * ' '}"
    end
  end
end
