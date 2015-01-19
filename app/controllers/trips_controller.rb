class TripsController < ApplicationController
  before_filter :fetch_trip, only: [:edit, :update, :destroy]

  def index
    @trips = policy_scope(Trip)
  end

  def new
    @trip = Trip.new
    authorize(@trip)
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    authorize(@trip)
    if @trip.save
      redirect_to user_root_path, notice: "Successfully added trip!"
    else
      render :new
    end
  end

  def edit
    authorize(@trip)
  end

  def update
    authorize(@trip)
    if @trip.update(trip_params)
      redirect_to user_root_path
    else
      render :edit
    end
  end

  def destroy
    authorize(@trip)
    if @trip.destroy
      redirect_to user_root_path
    else
      redirect_to user_root_path
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:user_id,
                                 :time_period,
                                 :purpose,
                                 :comments,
                                 :certainty,
                                 :private,
                                 :busy,
                                 destinations_attributes: [:id, :location_id, :start_date, :end_date])
  end

  def fetch_trip
    @trip = Trip.find(params[:id])
  end

end
