class Listing < ActiveRecord::Base
	if Rails.env.development?
			 has_attached_file :image, :styles => { :image => "200x", :thumb => "100x100>" }, :default_url => "default.png"
	else
			has_attached_file :image, :styles => { :image => "200x", :thumb => "100x100>" }, :default_url => "default.png",	
            :storage => :dropbox,
            :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
            :path => ":style/:id_:filename"
		end
      validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


      validates :name, :description, :price, presence: true
      #this line will validate that no listing will be in the system that has blanks
      validates :price, numericality: { grather_than: 0 }
      #this line will validate that no price will be zero and positive
      validates_attachment_presence :image
      #this line will validate the image field, and will not permit a blank field
end

#validates_attachment_content_type :image, :content_type => { :content_type => %w(image/jpeg image/jpg image/png) } 
#In order to make rails work locally with our pictures, and in production to heroku, we did the change.
#if Rails.env.development? and added the line :path => "style....."