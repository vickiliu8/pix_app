class PhotosController < ApplicationController
  def index
  	if params[:user_id]
  		@photos = Photo.where(user_id: current_user.id)
  	else
  		@photos = Photo.where(:public => true)
  	end
  end

  def new
  	@photo = current_user.photos.new
  end

  def create
		@photo = current_user.photos.create(photo_params) 
		if @photo.save
			redirect_to user_photo_path(current_user, @photo)
		else
			render :new
		end
  end

  def show
  		@photo = Photo.find(params[:id])
  end

  private
  def photo_params
  	params.require(:photo).permit(:caption, :public)
  end
end
