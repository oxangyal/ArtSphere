require 'rails_helper'

RSpec.describe Product, type: :model do
  it "creates a valid product" do
    product = FactoryBot.create(:product)
    expect(product).to be_valid
  end

  it "reads a product from the database" do
    product = FactoryBot.create(:product)
    found_product = Product.find(product.id)
    expect(found_product).to eq(product)
  end

  it "updates a product's attributes" do
    product = FactoryBot.create(:product)
    product.update(name: "Updated Product")
    expect(product.reload.name).to eq("Updated Product")
  end

  it "deletes a product" do
    product = FactoryBot.create(:product)
    expect { product.destroy }.to change(Product, :count).by(-1)
  end
end
