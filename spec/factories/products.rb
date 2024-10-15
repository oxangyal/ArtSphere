FactoryBot.define do
    factory :category do
      name { "painting" }
    end

    factory :product do
      name { "Barcelona sunset" }
      price { 1000.00 }
      material { "oil" }
      artist_name { "Eric Dukhovny" }
      original { true }
      year { 2015 }
      category

      transient do
        attach_images { true }
      end

      after(:build) do |product|
        product.images.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'barcelona.jpg')),
          filename: 'barcelona.jpg',
          content_type: 'image/jpeg'
        )
      end
    end
  end
