class EventsController < ApplicationController
  before_action :set_event
  # list all animals
  def index
    @events = Event.all
  end

  # create a new animal
  def new
    @event = Event.new
  end

  # perform create action
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path
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
  end

  def event_params
    params.require(:event).permit(:title, :user_id, :description, :sport_id, :start, :end)
  end

end