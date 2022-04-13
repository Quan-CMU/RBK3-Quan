class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  scope :newest, -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
end