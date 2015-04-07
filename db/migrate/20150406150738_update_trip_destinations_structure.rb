class UpdateTripDestinationsStructure < ActiveRecord::Migration
  def change
    add_column :trips, :start_date, :date
    add_column :trips, :end_date, :date

    Trip.all.each do |trip|
      trip.start_date = trip.destinations.minimum(:start_date)
      trip.end_date = trip.destinations.minimum(:end_date)
      trip.save
    end

    add_column :destinations, :day_offset, :integer, default: 0

    Destination.all.each do |destination|
      destination.day_offset = (destination.start_date - destination.trip.start_date).to_i
      destination.save
    end

    remove_column :destinations, :start_date
    remove_column :destinations, :end_date
  end
end