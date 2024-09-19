class Category < ApplicationRecord
  has_rich_text :description
  has_many_attached :images
  has_many :products
end
