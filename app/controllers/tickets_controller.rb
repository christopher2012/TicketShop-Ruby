class TicketsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  include TicketsHelper

  def create
    @event = Event.find(params[:event_id])
    ticket = @event.tickets.create ticket_params
    ticket[:user_id] = current_user[:id]
    ticket[:price] = ticket.count * event_price_boost(ticket.event)

    if ticket.save
      new_balance = ticket.user[:balance] - (ticket.event.price * ticket.count)
      current_user.update_attribute("balance", new_balance)

      flash[:success] = "Bilety zostały zakupione!"
    else
      flash[:danger] = "Podaj ilość biletów!"
    end

    redirect_to event_path(@event)
  end

  def cancel
    ticket = Ticket.find(params[:format])
    ticket.update_attribute(:to_delete, true)
    days = (ticket.event.date_event - ticket.updated_at.to_date).to_i
    flash[:success] = "Bilet został anulowany. Środki zostaną przekazane po zaakceptowaniu przez administratora. Zwrot: " + calculate_refund(ticket.price, days).to_s + " zł"
    redirect_to current_user

  end

  def confirm_cancel
    ticket = Ticket.find(params[:format])
    event = ticket.event
    days = (ticket.event.date_event - ticket.updated_at.to_date).to_i
    new_balance = ticket.user[:balance] + calculate_refund(ticket.price, days)
    ticket.user.update_attribute("balance", new_balance)
    ticket.update_attribute(:deleted, true)
    flash[:success] = "Bilet został usunięty."
    redirect_to event
  end

  def destroy
  end

  def ticket_params
    params.require(:ticket).permit(:count, :seat_number)
  end

end
