class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event, only: [:edit, :update, :destroy, :show]

  # list all animals
  def index
    @events = policy_scope(Event)
  end

  # create a new animal
  def new
    @event = Event.new
    authorize @event
  end

  # perform create action
  def create
    @event = Event.new(event_params)
    authorize @event

    @event.user = current_user
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  # display particular event
  def show
    @booking = Booking.new
    # authorize @booking
  end

  # edit event details
  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :new
    end
  end


  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def event_params
    params.require(:event).permit(:title, :user_id, :description, :sport_id, :start, :end)
  end

end
