class Photo < ActiveRecord::Base
	belongs_to :users
	has_many :comments
end
