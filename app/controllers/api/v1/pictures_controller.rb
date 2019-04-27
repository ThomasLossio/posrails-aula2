class Api::V1::PicturesController < ApplicationController
	def create
		picture = Picture.new create_picture_params
		if picture.save
			render json: picture, status: :created
		else
			render json: { errors: picture.errors }, status: :unprocessable_entity
		end
	end

	def index
		render json: Picture.all
	end

	private

	def create_picture_params
		params.permit(:name)
	end
end
