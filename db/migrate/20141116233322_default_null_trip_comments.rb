class DefaultNullTripComments < ActiveRecord::Migration
  def change
    Trip.all.each do |trip|
      unless trip.comments.present?
        trip.comments = nil
        trip.save
      end
    end
    change_column_default :trips, :comments, nil
  end
end
