module EventsHelper

  def archived_event(event)
    event.date_event < Date.today
  end

  def count_tickets(event)
    tickets = event.tickets

    tickets_number = 0
    tickets.each do |ticket|
      #logger.debug "Person attributes hash: #{ticket.attributes.inspect}"
      if !ticket.deleted && !ticket.new_record?
        tickets_number += ticket.count
      end
    end

    tickets_number
  end

  def event_price_boost(event)
    if event.date_event.today?
      (event.price * 1.2).round
    else
      event.price
end
  end

  def tickets_not_available(event)
    count_tickets(event) == event.seats
  end

  def age_valid(event)
    event.date_event.year - current_user.age.year > event.min_age
  end

  def enough_balance(event)
    current_user.balance > event.price
  end

  def can_sell_date(event)
    (event.date_event - Time.now.to_date).to_i <= 30
  end

  def can_sell(event)
    !archived_event(event) && age_valid(event) && enough_balance(event) && can_sell_date(event) && !tickets_not_available(event)
  end

end
