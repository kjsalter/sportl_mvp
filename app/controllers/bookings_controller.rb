class BookingsController < ApplicationController
  before_action :set_event
  # list all events
  def index
    @bookings = Booking.all
  end

  # create a new animal
  def new
    @booking = Booking.new
    authorize @booking
  end

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

  # edit booking details
  def review_booking
  end

  def update
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
