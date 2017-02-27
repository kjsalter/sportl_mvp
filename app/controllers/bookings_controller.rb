class BookingsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_event, only: [:create, :show]

  # list all events
  def index
    @bookings = Booking.all
  end

  # create a new booking
  # def new
  #   @booking = Booking.new
  #   authorize @booking
  # end

  # perform create action
  def create
    @booking = Booking.new(booking_params)
    authorize @booking

    if @booking.save
      redirect_to root_path
    else
      render :new
    end
  end

  # display particular booking
  def show
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

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:title, :user_id, :description, :sport_id, :start, :end)
  end
end
