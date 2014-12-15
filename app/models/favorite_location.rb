class FavoriteLocation < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  validates :location_id, uniqueness: { scope: :user_id, message: "already a favorite." }, presence: true
  validates :user_id, presence: true
end