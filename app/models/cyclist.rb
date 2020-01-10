class Cyclist < ActiveRecord::Base
  has_many :rides

  validates :username, presence:true
  validates :email, uniqueness:true

  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    Cyclist.all.detect {|x| slug == x.slug}
  end
end
