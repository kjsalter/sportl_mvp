class EventsController < ApplicationController
  before_action :set_event

  def index
  end

  def new
  end

  def create
  end

  def show
  end

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
