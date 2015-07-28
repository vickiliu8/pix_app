class CommentsController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.create(comment_params)
    @comment.name = current_user.name
    @comment.user_id = current_user.id
    @comment.save
    redirect_to photo_path(@photo)
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.find(params[:id])
    @comment.destroy
    redirect_to photo_path(@photo)

  end

  def edit
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to photo_path(@photo)
    else
      render :edit
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :user_id, :name)
    end
end