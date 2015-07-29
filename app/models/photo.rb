class Photo < ActiveRecord::Base
	belongs_to :users, dependent: :destroy
	has_many :comments, dependent: :destroy

	def liked!
    self.likes = self.likes + 1
    self.save
  end
end
