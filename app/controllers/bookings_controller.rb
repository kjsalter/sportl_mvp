class BookingsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_event, only: [:create]

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
    @booking = Booking.new
    # authorize @booking
    @booking.event = @event
    @booking.user = current_user

    if @booking.save
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

  def update
    @booking.update(booking_params)
    redirect_to booking_path(@booking)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
    authorize @event
  end

  def booking_params
    params.require(:booking).permit(:booking_state)
  end
end
