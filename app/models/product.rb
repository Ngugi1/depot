class Product < ApplicationRecord
  has_one_attached :image
  validates :price, numericality: { greater_than_or_equal_to: 0.01}
  validates :title, :description, :image, presence: true
  after_commit -> { broadcast_refresh_later_to "products"}
end
