module TicketsHelper

  def calculate_refund(price, days_left)
    (price - (price * (0.6 - (days_left * 0.5 / 30)))).to_i
  end

  def available_ticket_user_event(event, user_id)
    ticket_count = 0
    event.tickets.each do |ticket|
      if ticket.user_id == user_id
        ticket_count += ticket.count
      end
    end
    (5 - ticket_count)
  end

end
