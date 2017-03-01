class BookingsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_event, only: [:create]
  before_action :set_booking, only: [:update]


  # list all events
  def index
    @bookings = Booking.all
  end

  # create a new booking
  def new
    @booking = Booking.new
    # authorize @booking
  end

  # perform create action
  def create
    @booking = Booking.new(booking_params)
    # authorize @booking
    @booking.event = @event
    @booking.user = current_user

    if @booking.save
      @event.update_players
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  # display particular booking
  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  # Update booking with accept/deny
  def update
    params[:booking][:booking_state] = params[:booking][:booking_state].to_i
    @booking.update(booking_params)
    redirect_to booking_path(@booking)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
    authorize @event
  end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:booking_state, :no_players)
  end
end
