class Photo < ActiveRecord::Base
	belongs_to :users, dependent: :destroy
	has_many :comments, dependent: :destroy
end
