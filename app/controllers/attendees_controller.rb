class AttendeesController < ApplicationController
  before_action :find_attendee, only: [:show, :edit, :update, :destroy]
  def index
    @attendees = Attendee.all
  end

  def new
    @attendee = Attendee.new
  end

  def create
    @attendee = Attendee.new(attendee_params)

    if @attendee.save
      redirect_to attendees_path
    else
      render :new
    end
  end

  def update
    if @attendee.update_attributes(attendee_params)
      flash[:notice] = "Successfully updated attendee."
      redirect_to attendees_path
    else
      flash[:alert] = "Unable to update attendee."
      render :edit
    end
  end

  def destroy
    if @attendee.destroy
      flash[:notice] = "Successfully removed attendee #{@attendee.name}."
      redirect_to attendees_path
    else
      flash[:alert] = "Unable to remove attendee #{@attendee.name}."
      redirect_to users_path
    end
  end

  private

  def find_attendee
    @attendee = Attendee.find(params[:id])
  end

  def attendee_params
    params.require(:attendee).permit(
      :first_name, :last_name, :email, :company,
      :twitter_handle, :shirt_size, :dietary_restrictions
    )
  end
end
