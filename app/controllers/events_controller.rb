class EventsController < ApplicationController
  before_action :authorize!
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def update
    if @event.update_attributes(event_params)
      flash[:notice] = "Successfully updated event."
      redirect_to events_path
    else
      flash[:alert] = "Unable to update event."
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = "Successfully removed event #{@event.name}."
      redirect_to events_path
    else
      flash[:alert] = "Unable to remove event."
      redirect_to events_path
    end
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :logo, :start_date, :end_date)
  end
end
