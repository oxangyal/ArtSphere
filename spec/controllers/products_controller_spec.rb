require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:product) { create(:product) }
  let(:valid_attributes) do
    {
      name: 'Barcelona sunset',
      price: 1000.00,
      material: 'oil',
      artist_name: 'Eric Dukhovny',
      original: true,
      year: 2015,
      category_id: create(:category).id
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: product.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

   describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect {
          post :create, params: { product: valid_attributes.merge(images: [fixture_file_upload('spec/fixtures/files/barcelona.jpg', 'image/jpeg')]) }
        }.to change(Product, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { attributes_for(:product, price: nil) }

      it 'does not create a new Product' do
        expect {
          post :create, params: { product: invalid_attributes }
        }.not_to change(Product, :count)
      end

      it 'renders the new template' do
        post :create, params: { product: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { price: 20.0 } }

      it 'updates the requested product' do
        patch :update, params: { id: product.id, product: new_attributes }
        product.reload
        expect(product.price).to eq(20.0)
      end

      it 'redirects to the product' do
        patch :update, params: { id: product.id, product: new_attributes }
        expect(response).to redirect_to(product)
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template' do
        patch :update, params: { id: product.id, product: { price: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product' do
      product # Ensure the product is created
      expect {
        delete :destroy, params: { id: product.id }
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(products_url)
    end
  end
end
