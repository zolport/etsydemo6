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
end

#validates_attachment_content_type :image, :content_type => { :content_type => %w(image/jpeg image/jpg image/png) } 
#In order to make rails work locally with our pictures, and in production to heroku, we did the change.
#if Rails.env.development? and added the line :path => "style....."