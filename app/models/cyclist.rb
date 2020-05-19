class Cyclist < ActiveRecord::Base
  extend Concerns::Slugify::ClassMethods
  include Concerns::Slugify::InstanceMethods


has_many :rides

has_secure_password

validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

  def slug
      username.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
      Cyclist.all.find{|user| user.slug == slug}
    end

end
