class Product < ApplicationRecord
  has_one_attached :image
  validates :title, :description, :image, presence: true
  after_commit -> { broadcast_refresh_later_to "products"}
end
