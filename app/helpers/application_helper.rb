module ApplicationHelper
	def can_edit_photo?(photo)
		photo.user_id == current_user.id
	end
end
