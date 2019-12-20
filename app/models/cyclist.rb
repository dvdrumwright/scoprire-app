class Cyclist < ActiveRecord::Base
  has_many :rides
  belongs_to :post

  validates :name, :user, presence: true
  validates :name, uniqueness: true

  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    Cyclist.all.detect {|x| slug == x.slug}
  end
end
