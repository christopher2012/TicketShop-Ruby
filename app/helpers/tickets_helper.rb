module TicketsHelper

  def calculate_refund(price, days_left)
    (price - (price * (0.6 - (days_left * 0.5 / 30)))).to_i
  end

end
