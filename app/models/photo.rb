class Photo < ActiveRecord::Base
	belongs_to :users
	has_many :comments, dependent: :destroy
 	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png", dependent: :destroy,
 	        :storage => :s3,
            :bucket  => ENV['AWS_BUCKET'],
            :s3_credentials => S3_CREDENTIALS
            
 	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

 	def liked!
	    self.likes = self.likes + 1
	    self.save
 	end
end
