class BookingsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_event, only: [:create, :show]

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
  end

  # accept the booking
  def accept_booking
    # booking_state = 1 means accepted
    @booking.booking_state = 1

    if @booking.save
      redirect_to root_path
    else
      render :new
    end
  end

  def deny_booking
    # booking_state = 2 means denied
    @booking.booking_state = 2

    if @booking.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
