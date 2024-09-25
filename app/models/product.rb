class Product < ApplicationRecord
  has_rich_text :description
  has_many_attached :images
  belongs_to :category, optional: true

  validates :price, presence: true, numericality: { greater_than: 0 }
  validate :images_validation

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
