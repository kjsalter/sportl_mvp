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

  def pending_denied_show
    @booking = Booking.find(params[:id])
    authorize @booking

    @events = [@booking.event]
    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  # perform create action
  def create
    @booking = Booking.new(booking_params)
    # authorize @booking
    @booking.event = @event
    @booking.user = current_user

    if @booking.save
      @event.update_players
      Notification.create(content: "#{@booking.user.username} has requested to join '#{@booking.event.title}'", user: @booking.event.user, notificationable: @booking)
      redirect_to pending_path(@booking)
    else
      render :new
    end
  end

  # display particular booking
  def show
    @booking = Booking.find(params[:id])
    authorize @booking

    @events = [@booking.event]
    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  # Update booking with accept/deny
  def update
    params[:booking][:booking_state] = params[:booking][:booking_state].to_i
    @booking.update(booking_params)
    if params[:booking][:booking_state] == 2
      #booking is now denied
      @booking.booking_denied
      Notification.create(content: "#{@booking.event.user.username} has denied your request to join '#{@booking.event.title}'", user: @booking.user, notificationable: @booking)
    end
    if params[:booking][:booking_state] == 1
      #create a notif for user and booking
      Notification.create(content: "#{@booking.event.user.username} has accepted your request to join '#{@booking.event.title}'", user: @booking.user, notificationable: @booking)
    end
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
