class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :protected]
  before_action :set_event, only: [:edit, :update, :destroy, :show, :protected, :create_players]
  before_action :create_players, only: [:update]
  skip_after_action :verify_policy_scoped, only: :index

  def index

# This is the search
# Overall list
    @events = Event.all
    @events = @events.where("active = true")
# by location
    @events = @events.near(params[:location], params[:radius]) if params[:location].present? && params[:radius].present?
    @radius = 15
    @events = @events.near(params[:location], @radius) if params[:location].present?
# by time
    @events = @events.where(['start_time >= ? and end_time <= ?', params[:start], params[:end]]) if params[:start].present? && params[:end].present?    # by sports
# by sports
    @events = @events.joins(:sport).where(sports: { name: params[:sports] }) if params[:sports].present? && Sport.all.map(&:name).include?(params[:sports][0])
# by spaces
    @events = @events.where('missing_player >= ?', params[:missing_player]) if params[:missing_player].present?
    # @events = @events.where('missing_player > 0')
# by vibe
    @events = @events.where(level: params[:event_vibe]) if params[:event_vibe].present?
    # @events = @events.where('gender = ?', params[:gender]) if (params[:gender].downcase == "male") || (params[:gender].downcase == "female")
# by type
    @events = @events.where(gender: params[:event_type]) if params[:event_type].present?
# by friends
    # @events = @events.where('friends = ?', params[:friends_radio]) if params[:friends_radio].present?

    @sports_list = Event.all.map { |event| event.sport.name }.uniq
    @searcher_coordinates = Geocoder.coordinates(params[:location])

    # Sorting
    case params[:sort]
    when 'distance'
      @events = @events.distance_from_sorted @searcher_coordinates
    else
      @events = @events.reorder((params[:sort].to_sym || :start_time) => (params[:order].to_sym || :desc)) if params[:sort].present?
    end
    # Old search keep for reference
    # @events = Event.search_event(params[:sports], params[:start], params[:end], params[:missing_player], params[:location], params[:radius])

    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end
  end

  # create a new event
  def new
    @event = Event.new
    authorize @event
  end

  # perform create action
  def create
    @event = Event.create(event_params.except(:player_ids))
    authorize @event
    create_players

    # Create players using @event and selected user(s)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  # display particular event
  def show
    @booking = Booking.new
    # authorize @booking

    @events = [@event]
    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def protected
    redirect_to @event
  end

  # edit event details
  def edit
  end

  def update
    # params[:event][:player_ids] = @players
    if @event.update(event_params.except(:player_ids))
      redirect_to event_path(@event)
    else
      render :new
    end
  end


  def destroy
    @event.update(active: false)
    redirect_to events_path
  end

  private

  def create_players
    # User.where("username = ?", event_params[:player_ids][1])
    @event.players.destroy_all
    params[:event][:player_ids].each do |username|
      if username.present?
        working_user = User.where("username = ?", username).first
        @event.players << Player.create!(event: @event, user: working_user)
      end
    end
    # params[:event][:player_ids] = @players
  end

  def set_event
    @event = Event.find(params[:id])
    @users = User.all
    authorize @event
  end

  def event_params
    params.require(:event).permit(:title, :user_id, :description, :postcode, :sport_id, :start_time, :end_time, :missing_player, :requirements, :level, :address, :city, :country, :venue_name, :gender, player_ids: [])
  end

end
