class Product < ApplicationRecord
  has_rich_text :description
  has_many_attached :images
  belongs_to :category, optional: true

   # Association with favorites
   has_many :favorites, dependent: :destroy
   has_many :favorited_by, through: :favorites, source: :user

  validates :price, presence: true, numericality: { greater_than: 0 }
  validate :images_validation
  validates :material, presence: true
  validates :artist_name, presence: true, length: { minimum: 2 }
  validates :original, inclusion: { in: [true, false] }
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1500, less_than_or_equal_to: Date.today.year }

  private

  def images_validation
    if images.attached?
      images.each do |image|
        if !image.content_type.in?(%w(image/jpeg image/png))
          errors.add(:images, 'must be a JPEG or PNG file')
        end
      end
    else
      errors.add(:images, 'must be attached')
    end
  end
end
