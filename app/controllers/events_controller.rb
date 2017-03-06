class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :protected]
  before_action :set_event, only: [:edit, :update, :destroy, :show, :protected, :create_players]
  before_action :create_players, only: [:update, :create]
  skip_after_action :verify_policy_scoped, only: :index

  # list all animals
  def index

    # This is the search
    @events = Event.all
    @events = Event.where(['start_time >= ? and end_time <= ?', params[:start], params[:end]]) if params[:start].present? && params[:end].present?
    @events = @events.near(params[:location], params[:radius]) if params[:location].present? && params[:radius].present?
    @events = @events.joins(:sport).where(sports: { name: params[:sports] }) if Sport.all.map(&:name).include? params[:sports]
    @events = @events.where('missing_player >= ?', params[:missing_player]) unless params[:missing_player] == "Party size"
    @events = @events.where('missing_player > 0')
    @events = @events.where("active = true")

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

  # create a new animal
  def new
    @event = Event.new
    authorize @event
  end

  # perform create action
  def create
    @event = Event.new(event_params)
    authorize @event

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
    @event.players.destroy_all
    # params[:event][:player_ids] = @players

    if @event.update(event_params)
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
    @players = []
    event_params[:player_ids].each do |username|
      if username.present?
        working_user = User.where("username = ?", username)
        @players << Player.create(event: @event, user: working_user[0])
      end
    end
  end

  def set_event
    @event = Event.find(params[:id])
    @users = User.all
    authorize @event
  end

  def event_params
    params.require(:event).permit(:title, :user_id, :description, :postcode, :sport_id, :start_time, :end_time, :missing_player, :requirements, :level, player_ids: []) # May need to add players / player_id / player_ids. I don't know :)
  end

end
