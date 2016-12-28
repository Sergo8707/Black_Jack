class Bank
  attr_reader :value

  def initialize
    @value ||= 0
  end

  def push(rate)
    @value += rate
  end

  def pop_all
    value = @value
    @value = 0
    value
  end
end
