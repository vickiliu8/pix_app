class PhotosController < ApplicationController
	before_action :check_user, only: [:edit]

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

  private
  def check_user
  	 unless current_user.id == Photo.find(params[:id]).user_id
  	 	flash[:alert] = "Cannot edit another users photo!"
  	 	redirect_to 'welcome_index_path'

  	 end
  end
  def photo_params
  	params.require(:photo).permit(:caption, :public, :user_id)
  end
end
