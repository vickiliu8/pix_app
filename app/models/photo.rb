class Photo < ActiveRecord::Base
	belongs_to :users
	has_many :comments, dependent: :destroy

	def liked!
	    self.likes = self.likes + 1
	    self.save
 	end

 	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png", dependent: :destroy,
 	        :storage => :s3,
            :bucket  => ENV['MY_BUCKET_NAME']
            
 	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
