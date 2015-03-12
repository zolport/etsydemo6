class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         validates :name, presence: true
         #this line below states the relationship with the Listings data base, saying that a user
         #can have many listing and when the user is destroy the listings will be destroy as well.
         has_many :listings, dependent: :destroy

         #these thwo line create the relationship of User with sales and purchases
         has_many :sales, class_name: "Order", foreign_key: "seller_id"
         has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
end
