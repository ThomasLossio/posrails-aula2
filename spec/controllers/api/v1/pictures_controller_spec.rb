require 'rails_helper'

RSpec.describe Api::V1::PicturesController, type: :controller do
  describe "#show" do
    let!(:picture) { create :picture, :with_image }
    context 'When picture exists' do
      before do
        get :show, params: { id: picture.id }
      end
      it "responds :ok" do
        expect(response).to have_http_status(:ok)
      end
      it "contains the picture" do
        expected_picture_json = PictureSerializer.new(picture).to_json
        expect(response.body).to eq(expected_picture_json)
      end
    end
    context 'When picture does not exist' do
      before do
        get :show, params: { id: -1 }
      end
      it 'responds :not_found' do
        expect(response).to have_http_status(:not_found)
      end
      it 'contains not_found message' do
        expect(response.body).to include('not found')
      end
    end

  end

  describe "#index" do
    let!(:picture) { create :picture, :with_image }
    before do
      get :index
    end
    it "responds :ok" do
      expect(response).to have_http_status(:ok)
    end
    it "contains all pictures" do
      pictures = ActiveModel::SerializableResource.new(
        Picture.all,
        each_serializer: PictureSerializer
      ).to_json
      expect(response.body).to eq(pictures)
    end
  end
end
