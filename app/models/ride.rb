class Ride < ActiveRecord::Base
  belongs_to :cyclist
  has_many :post

   validates :ride_date, :location, :description, :ride_distance, presence: true

   def slug
       self.name.downcase.split(" ").join("-")
     end

     def self.find_by_slug(slug)
       Ride.all.detect {|x| slug == x.slug}
     end
   end

end
