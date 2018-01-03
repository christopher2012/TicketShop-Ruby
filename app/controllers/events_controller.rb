class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show]

  # GET /events
  # GET /events.json
  def index
    if current_user && current_user.admin
      @events = Event.all
    else
      @events = Event.all.select{|event| !archived_event(event)}
    end

  end

  # GET /events/1
  # GET /events/1.json
  def show
    @tickets = @event.tickets.select {|ticket| !ticket.deleted}

    if !can_sell_date(@event)
      flash.now[:success] = "Bilety będą dostępne 30 dni przed wydarzeniem."
    elsif archived_event(@event)
      flash.now[:danger] = "Wydarzenie jest archiwalne."
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        flash[:success] = "Wydarzenie zostało utworzone."
        format.html {redirect_to @event}
        format.json {render :show, status: :created, location: @event}
      else
        format.html {render :new}
        format.json {render json: @event.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        flash[:success] = "Wydarzenie zostało pomyślnie zmodyfikowane."
        format.html {redirect_to @event}
        format.json {render :show, status: :ok, location: @event}
      else
        format.html {render :edit}
        format.json {render json: @event.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html {redirect_to events_url, notice: 'Event was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:date_event, :name, :description, :min_age, :seats, :price, :image)
  end
end
