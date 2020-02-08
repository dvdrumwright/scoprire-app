class Cyclist < ActiveRecord::Base

attr_accessor :email, :username, :password, :password_confirmation


has_secure_password


has_many :rides


  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }


  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    Cyclist.all.detect {|x| slug == x.slug}
  end

end
