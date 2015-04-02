class Notification < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :notifiable, polymorphic: true

  validates :user_id, presence: true
  validates :notifiable_id, presence: true
  validates :notifiable_type, presence: true
end