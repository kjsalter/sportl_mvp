class EventsController < ApplicationController
  before_action :set_event
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

    if @event.save
      redirect_to root_path
    else
      render :new
    end
  end

  # display particular event
  def show
  end

  # edit event details
  def edit
  end

  def update
  end

  def destory
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
