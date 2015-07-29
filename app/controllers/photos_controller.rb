class PhotosController < ApplicationController
	before_action :check_user, only: [:edit, :destroy]
	
  def index
  	@is_owner = false
  	@photos = Photo.where(:public => true)
  	# if params[:user_id]
  	# 	@photos = Photo.where(user_id: current_user.id)
  	# else
  	# 	@photos = Photo.where(:public => true)
  	# end
  end

  def my_photos
  	@is_owner = true
  	@photos = current_user.photos
  end


  def new
  	@photo = current_user.photos.new
  end

  def create
		@photo = current_user.photos.create(photo_params) 

		if @photo.save
			redirect_to photo_path(@photo)
		else
			render :new
		end
  end

  def show
  		@photo = Photo.find(params[:id])
  		@is_owner = false
  		if @photo.user_id == current_user.id
  			@is_owner = true
  		end
  end

  def destroy
  	@photo = Photo.find(params[:id])
		@photo.destroy
		redirect_to photos_path
  end

  def edit
  	@photo = Photo.find(params[:id])
  end

  def update
		@photo = Photo.find(params[:id])
		if @photo.update(photo_params)
			redirect_to photo_path(@photo)
		else
			render :edit
		end
	end

  def like
  	@photo = Photo.find(params[:id])
    @photo.liked!
    redirect_to @photo
  end

  private
  def check_user
  	@photo = Photo.find(params[:id])
  	 unless current_user.id == Photo.find(params[:id]).user_id
  	 	flash[:alert] = "You cannot edit another users photo!"
  	 	redirect_to @photo

  	 end
  end
  def photo_params
  	params.require(:photo).permit(:caption, :public, :user_id, :avatar)
  end
end
