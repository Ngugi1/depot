class Product < ApplicationRecord
  has_one_attached :image
  validates :price, numericality: { greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validate :acceptable_image
  validates :title, :description, :image, presence: true
  after_commit -> { broadcast_refresh_later_to "products"}


  def acceptable_image
    return unless image.attached?
    acceptable_types = ["image/jpeg", "image/png", "image/gif"]

    unless acceptable_types.include?(image.content_type)
      errors.add(:image,"must be a GIF, JPG or PNG image")
    end
  end
end
