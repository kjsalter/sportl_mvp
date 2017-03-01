class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event, only: [:edit, :update, :destroy, :show]
  skip_after_action :verify_policy_scoped, only: :index

  # list all animals
  def index

    @events = Event.all
    if params[:start].present? && params[:end].present?
      @events = Event.where(['start > ? and created_at < ?', DateTime.now - 10, DateTime.now + 2])
    end

    @events = @events.near(params[:location], params[:radius]) if params[:location].present? && params[:radius].present?

    # `joins` join all the sports associated to events
    @events = @events.joins(:sport).where(sports: { name: params[:sports] }) if Sport.all.map(&:name).include? params[:sports]
    # @events = @events.where(params[:start] > Time.now)

    #@events = @events.order('#{params[:sort] || 'start' }" => "#{params[:order] || 'date' }")



    # Event.reindex
    # # @search_events = Event.search_event(params[:sports], params[:start], params[:end], params[:location], params[:radius])

    # # @ordered_events = Event.search order: {start: params[:order] || :asc}

    # # match_events

    # @events = Event.search_event(params[:sports], params[:start], params[:end], params[:location], params[:radius])
    # raise
    # @events = @events.search order: { start: params[:order] || :asc }


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
    params[:event][:start] = DateTime.parse(params[:start])
    params[:event][:end] = DateTime.parse(params[:end])
    @event = Event.new(event_params)
    authorize @event
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
    params.require(:event).permit(:title, :user_id, :description, :postcode, :sport_id, :start, :end, :missing_player)
  end

end
