class Numeric
  
  def evenize(operator = '+')
    raise ArgumentError, "invalid argument (must be `+' or `-')" unless %w(+ -).include?(operator)
    round.send(operator, modulo(2))
  end
  
  def oddize(operator = '+')
    raise ArgumentError, "invalid argument (must be `+' or `-')" unless %w(+ -).include?(operator)
    self %2 > 0 ? self : round.send(operator, 1)
  end
  
end